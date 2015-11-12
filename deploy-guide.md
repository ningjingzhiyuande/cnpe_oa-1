# 文洋测试服务器部署指南

```bash
appdir=/home/yang/Sites/cnpe_oa
```

## Step1: 获取代码

在appdir放入最新的cnpe_oa代码 # laocao 版本： https://github.com/cao7113/cnpe_oa

手动配置config/database.yml 

去掉 app/mailers/order_mailer.rb 第九行 emails=PreGood.这一行

```bash
cd $appdir
bundle install
```

## Step2: 构建DB

```bash
rake db:create:all #第一次部署时执行

bundle exec rake db:migrate
RAILS_ENV=production bundle exec rake db:migrate
```

# 可用rails s 本地运行开发模式测试

## Step3: 编译静态资源

```bash
RAILS_ENV=production bundle exec rake assets:precompile
RAILS_ENV=production bundle exec rake kindeditor:assets
```

## Step4 配置unicorn

仿照之前项目的unicorn的配置， 制作 /etc/init.d/unicorn_cnpe_oa.sh

启动unicorn

```bash
/etc/init.d/unicorn_cnpe_oa start
```

有问题时查看unicorn 错误日志： log/unicorn*.log

## Step5 配置nginx

仿照之前项目的nginx的配置， 制作 /etc/nginx/sites-enable/cnpe_oa.conf
重启nginx  

```bash
sudo service nginx restart
```

有问题时查看nginx错误日志 /var/log/nginx*

## 测试部署是否成功

访问/etc/nginx/sites-enable/cnpe_oa.conf 中配置的域名

并观察unicorn和nginx log，如有错误作相应调整

## 特别提示：

1. 因为当时没测试, 请检查 $appdir/config/unicorn.rb中的配置信息 和 /etc/init.d/unicorn_cnpe_oa.sh中配置时对应，否则可能导致问题  
2. 请妥善处理之前部署的项目(如关停，或数据如何转移到新项目中来），以免和当前项目产生配置冲突

相关问题请联系国栋或老曹
