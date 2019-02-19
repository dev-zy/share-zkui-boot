#!/bin/bash
path="${BASH_SOURCE-$0}"
path="$(dirname "${path}")"
path="$(cd "${path}";pwd)"
base=${path}/..
BASE_PATH="$(cd "${base}";pwd)"
case "`uname`" in
    Linux)
		linux=true
		;;
	*)
		linux=false
		;;
esac
APP_NAME=zkui
CONF=${BASE_PATH}/config/application.properties
LOG=${BASE_PATH}/logs/${APP_NAME}.log
PID=${BASE_PATH}/data/${APP_NAME}.pid

if [ -f $PID ] ; then
	kid="`cat $PID`"
fi

if [ -n $kid ] ; then
	echo "[`hostname -i`][`uname`] ${APP_NAME} process [$kid] is Running!"
	kill -9 $kid;
fi

if [ -n "${APP_NAME}" ] ; then
	kid=`ps -ef |grep ${APP_NAME}|grep -v grep|awk '{print $2}'`
	echo "[${SERVER_IP}]pid[$kid] from `uname` system process!"
fi

if [ -f $LOG ] ; then
	rm -rf ${BASE_PATH}/logs/*
fi

if [ -n "${kid}" ]; 
then
	echo "${APP_NAME} pid:${kid}"
	kill -9 ${kid}
	echo ----------------------------${app_name} STOPED SUCCESS------------------------------------
else
	echo "${APP_NAME} pid isn't exist or has STOPED !"
fi

if [ -f $PID ]; then
	rm -rf $PID
	echo "If there is a problem, Please check the log!"
fi