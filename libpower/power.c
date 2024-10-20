/*
 * Copyright (C) 2012 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <dirent.h>
#include <stdlib.h>

#define LOG_TAG "PowerHAL"
#include <utils/Log.h>

#include <hardware/hardware.h>
#include <hardware/power.h>

#define POWER_HAL_CONF "/etc/powerhal.conf"

#define PM_CONTROL "control"
#define PM_STATUS "runtime_status"

#define DEV_MAX 2048
#define ERR_MAX 256
#define STATUS_MAX 64

static const char *pm_state_auto = "auto";
static const char *pm_state_on = "on";

struct node{
    char device[DEV_MAX];
    struct node *next;
    struct node *prev;
};

struct list{
    struct node *first;
    struct node *last;
};

struct list devices;

int add_to_list(char *device)
{
    struct node *node = malloc(sizeof(struct node));
    if(node == NULL){
        ALOGE("malloc failed for creating new node");
        return -1;
    }

    memset(node, 0, sizeof(struct node));
    strcpy(node->device, device);

    if(devices.first == NULL){
        devices.first = devices.last = node;
    }else{
        devices.last->next = node;
        node->prev = devices.last;
        devices.last = node;
    }

    return 0;
}

int is_pm_supported(char *control, char *status)
{
    char buf[ERR_MAX];
    char sbuf[STATUS_MAX];

    int ret;
    int fd;

    ret = access(control, F_OK);
    if (ret < 0) {
        ALOGW("%s doesn't exist\n", control);
        return -1;
    }

    fd = open(status, O_RDONLY);

    if (fd < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGW("Error opening %s: %s\n", status, buf);
        return -1;
    }

    ret = read(fd, sbuf, 12);
    if (ret < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGW("Error reading %s: %s\n", status, buf);
        close(fd);
        return -1;
    }

    if(strncmp(sbuf, "unsupported", 11) == 0){
        ALOGW("%s is unsupported\n", status);
        close(fd);
        return -1;
    }

    close(fd);
    return 0;
}

void wait_for_set_complete(char *status, int on)
{
    int fd;
    int ret;
    char buf[80];
    char sbuf[64];
    int count = 1000;

    do{
        memset(sbuf, 0, 64);
        fd = open(status, O_RDONLY);

        if (fd < 0) {
            strerror_r(errno, buf, sizeof(buf));
            ALOGE("Error opening %s: %s\n", status, buf);
            return;
        }

        ret = read(fd, sbuf, 12);
        if (ret < 0) {
            strerror_r(errno, buf, sizeof(buf));
            ALOGE("Error reading %s: %s\n", status, buf);
            close(fd);
            continue;
        }

        if(strncmp(sbuf, "unsupported", 11) == 0){
            ALOGE("%s is unsupported\n", status);
            close(fd);
            break;
        }

        if((on && (strncmp(sbuf, "active", 6) == 0)) || (!on && (strncmp(sbuf, "suspended", 9) == 0))){
            close(fd);
            break;
        }

        close(fd);

        usleep(1000);
        count--;
    }while(count > 0);

    if(count <= 0){
        ALOGW("DEVICE SUSPEND/RESUME FAILED!\n");
    }

    ALOGI("wait_for_set_complete done, status is %s", sbuf);
}

int pm_device_set(char *devname, int on)
{
    char status[DEV_MAX];
    char buf[ERR_MAX];
    char* onBuf;

    int ret;
    int fd;

    ALOGI("power_set_for_device %s with on %d\n",  devname, on);

    fd = open(devname, O_RDWR);

    if (fd < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error opening %s: %s\n", devname, buf);
        return -1;
    }

    onBuf = on ? "1" : "0";
    ret = write(fd, onBuf, 1);
    if (ret < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error writing %s to %s: %s\n", onBuf, devname, buf);
        goto err;
    }
    ALOGI("write %s done\n", onBuf);

err:
    close(fd);
    return ret;

}

int pm_set_for_device(char *devname, int on)
{
    char status[DEV_MAX];
    char control[DEV_MAX];
    char buf[ERR_MAX];
    char sbuf[STATUS_MAX];

    int ret;
    int fd;

    ALOGI("power_set_for_device %s with on %d\n",  devname, on);

    strcpy(control, devname);
    strcat(control, "/");
    strcat(control, PM_CONTROL);

    strcpy(status, devname);
    strcat(status, "/");
    strcat(status, PM_STATUS);

    if (is_pm_supported(control, status) != 0){
        return -1;
    }

    fd = open(control, O_RDWR);

    if (fd < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error opening %s: %s\n", control, buf);
        return -1;
    }

    ALOGI("%s opened\n", control);
    if (on){
        ret = write(fd, pm_state_on, strlen(pm_state_on));
        if (ret < 0) {
            strerror_r(errno, buf, sizeof(buf));
            ALOGE("Error writing %s to %s: %s\n", pm_state_on, control, buf);
            goto err;
        }
        ALOGI("write %s done\n", pm_state_on);
    } else {
        ret = write(fd, pm_state_auto, strlen(pm_state_auto));
        if (ret < 0) {
            strerror_r(errno, buf, sizeof(buf));
            ALOGE("Error writing %s to %s: %s\n", pm_state_auto, control, buf);
            goto err;
        }
        ALOGI("write %s done\n", pm_state_auto);
    }

    wait_for_set_complete(status, on);

err:
    close(fd);
    return ret;

}

static void power_init(struct power_module *module)
{
    FILE *conf = fopen(POWER_HAL_CONF, "r");

    if (conf == NULL)
    {
        ALOGW("%s does not exist! No devices for early suspend/late resume", POWER_HAL_CONF);
        return;
    }

    char line[DEV_MAX];
    int i = 0;

    memset(line, 0, DEV_MAX);
    while (fgets(line, DEV_MAX, conf) != NULL)
    {
        //skip comment,nl and space
        if (line[0] == '#' || line[0] == 0x0a || line[0] == 0x20)
            continue;

        line[strlen(line) - 1] = '\0'; //eliminate line break

        ALOGI("add device %s to list\n", line);
        if (add_to_list(line) != 0){
            ALOGE("add device %s to list failed\n", line);
        }
        memset(line, 0, DEV_MAX);
    }

    fclose(conf);

}

static void power_set_interactive(struct power_module *module, int on)
{
    ALOGI("power_set_interactive called with on %d\n", on);
    struct node *node;

    if (on){
        for(node = devices.last; node != NULL; node = node->prev) {
            pm_set_for_device(node->device, on);
        }
        pm_device_set("/sys/devices/platform/dcon/sleep", 0);
        pm_device_set("/sys/class/backlight/dcon-bl/bl_power", 0);
    }else{
        for (node = devices.first; node != NULL; node = node->next) {
            pm_set_for_device(node->device, on);
        }
        pm_device_set("/sys/devices/platform/dcon/sleep", 1);
        pm_device_set("/sys/class/backlight/dcon-bl/bl_power", 1);
    }
}

static void power_hint(struct power_module *module, power_hint_t hint,
                       void *data) {
    switch (hint) {
    default:
        break;
    }
}

static struct hw_module_methods_t power_module_methods = {
    .open = NULL,
};

struct power_module HAL_MODULE_INFO_SYM = {
    .common = {
        .tag = HARDWARE_MODULE_TAG,
        .module_api_version = POWER_MODULE_API_VERSION_0_2,
        .hal_api_version = HARDWARE_HAL_API_VERSION,
        .id = POWER_HARDWARE_MODULE_ID,
        .name = "Marvell Power HAL",
        .author = "The Android Open Source Project",
        .methods = &power_module_methods,
    },

    .init = power_init,
    .setInteractive = power_set_interactive,
    .powerHint = power_hint,
};
