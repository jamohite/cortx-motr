#!/bin/bash
#
# Copyright (c) 2020 Seagate Technology LLC and/or its Affiliates
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# For any questions about this software or licensing,
# please email opensource@seagate.com or cortx-questions@seagate.com.
#

# Get local address and other parameters to start services
#modprobe lnet &>> /dev/null
#lctl network up &>> /dev/null
#LOCAL_NID=`lctl list_nids | head -1`
LOCAL_NID=`ip addr show eth0|grep inet| head -1|awk '{print $2}'|cut -d '/' -f1`
LOCAL_NID=$LOCAL_NID@tcp

if [ X$LOCAL_NID == X ]; then
	echo "lnet is not up"
	exit
fi

if [ X$MOTR_LOCAL_EP == X ]; then
	MOTR_LOCAL_EP=$LOCAL_NID:12345:34:101
	MOTR_LOCAL_EP2=$LOCAL_NID:12345:34:102
	MOTR_LOCAL_EP3=$LOCAL_NID:12345:34:103
	MOTR_LOCAL_EP4=$LOCAL_NID:12345:34:104
fi

if [ X$MOTR_HA_EP == X ]; then
	MOTR_HA_EP=$LOCAL_NID:12345:34:1
fi

if [ X$MOTR_PROF_OPT == X ]; then
	MOTR_PROF_OPT=0x7000000000000001:0
fi

if [ X$MOTR_PROC_FID == X ]; then
	MOTR_PROC_FID=0x7200000000000000:0
fi
