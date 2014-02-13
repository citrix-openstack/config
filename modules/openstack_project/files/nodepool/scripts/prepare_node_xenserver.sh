#!/bin/bash -xe

# Copyright (C) 2011-2013 OpenStack Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
#
# See the License for the specific language governing permissions and
# limitations under the License.

HOSTNAME=$1
SUDO='true'
BARE='true'

./prepare_node.sh "$HOSTNAME" "$SUDO" "$BARE"
sudo -u jenkins -i /opt/nodepool-scripts/prepare_devstack.sh $HOSTNAME

# This is the extra step compared to prepare_node_devstack.sh
# We shut down the hypervisor, to make sure, that all the filesystems are unmounted properly

SSH_DOM0="sudo -u domzero ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@192.168.33.2"
FEED_WITH_NOTHING="< /dev/null"

$SSH_DOM0 halt -p $FEED_WITH_NOTHING
