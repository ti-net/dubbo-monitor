#!/bin/bash
#40 0 * * * /usr/local/bin/dubbo-monitor-rotate.sh
#每天凌晨清理一次dubbo-monitor数据库中dubbo-invoke表数据
#部署在dubbo-monitor所在服务器上

rotate_day=7
properties_url=/usr/local/cti-link/dubbo-monitor-handu/WEB-INF/classes/app.properties
db_url=`cat ${properties_url}|grep 'db.url'`
db_url=`echo ${db_url#*//}`
db_host_port=`echo ${db_url}|awk -F '/' '{print $1}'`
db_name=`echo ${db_url}|awk -F '/' '{print $2}'`
db_host=`echo ${db_host_port}|awk -F ':' '{print $1}'`
db_port=`echo ${db_host_port}|awk -F ':' '{print $2}'`

if [ "x${db_port}" = "x" ]; then
	db_port=5432
fi
db_username=`cat ${properties_url}|grep 'db.username'|awk -F '=' '{print $2}'`
db_password=`cat ${properties_url}|grep 'db.password'|awk -F '=' '{print $2}'`
max_invoke_time=$(date +%s --date "${rotate_day} days ago")000 

echo ${db_host}
echo ${db_port}
echo ${db_name}
echo ${db_username}
echo ${db_password}
export PGPASSWORD=${db_password}
psql -h ${db_host} -p ${db_port} -d ${db_name} -U ${db_username} -c "delete from dubbo_invoke where invoke_time < ${max_invoke_time}"
