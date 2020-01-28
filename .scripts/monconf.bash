#!/bin/bash

function countMonitors() {
    return $(xrandr --current | grep ' connected' | wc -l)
}

function setLaptopLayout() {
    sh ~/.screenlayout/laptop1152.sh
}

function setOfficeLayout() {
    sh ~/.screenlayout/office.sh
}

MON_COUNT="$countMonitors"

if [ "$MON_COUNT" = "1" ]; then
    setLaptopLayout
else
    setOfficeLayout
fi

