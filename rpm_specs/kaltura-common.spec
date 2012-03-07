%define prefix /opt/kaltura
%define kaltura_user kaltura
%define kaltura_uid 1200
Name: kaltura-common
Version: 5.0.0 
ExclusiveArch: i686 x86_64 i386 amd64 
Release: 6%{?dist}
Summary: Kaltura's video platform is designed to help you create value with video. 

Group: Applications/Multimedia
License: GPLv3+
URL: http://kaltura.com
Source0: http://cdnbakmi.kaltura.com/content/files/OnPrem_v5.0_Linux_Install.tar.gz
Source1: kaltura-httpd.conf.tmpl
Source2: kaltura-logrotate
Source3: kaltura-sphinx.conf
SOurce4: kConfLocal.php.template
Source5: kaltura-searchd
Source6: kaltura-application.ini.template
Source7: clear_cache.php
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

Requires: httpd php53-soap php-pear kaltura-mediainfo rsync curl java-1.6.0-openjdk php53-common php53-mysql php53 php53-xml php53-pdo php53-cli php53-gd 

%description
Kaltura's video platform is designed to help you create value with video.
With Kaltura's wide range of features and powerful tools you'll quickly expand your audience, generate revenue, and create more effective digital communications.

%prep
%setup -qn Kaltura-TM-v%{version} 

%build

%install
mkdir -p $RPM_BUILD_ROOT%{prefix}/log/sphinx \
	$RPM_BUILD_ROOT%{prefix}/var/sphinx/data \
	$RPM_BUILD_ROOT%{prefix}/cache \
	$RPM_BUILD_ROOT%{prefix}/app \
	$RPM_BUILD_ROOT%{prefix}/bin \
	$RPM_BUILD_ROOT%{_sysconfdir}/httpd/conf.d \
	$RPM_BUILD_ROOT%{_sysconfdir}/logrotate.d \
	$RPM_BUILD_ROOT%{_sysconfdir}/init.d

for i in package/app/app/configurations/*;do 
	sed -i 's^@APP_DIR@^%{prefix}^g' $i/*
	sed -i 's^@LOG_DIR@^%{prefix}/log^g' $i/*
	sed -i 's^@TMP_DIR@^%{prefix}/tmp^g' $i/*
	sed -i 's^@WEB_DIR@^%{prefix}/web^g' $i/*
	sed -i 's^@BIN_DIR@^%{prefix}/bin^g' $i/*
	sed -i 's^@DWH_DIR@^%{prefix}/dwh^g' $i/*

done
#/opt/kaltura/app/infra/general/../../alpha/config/kConfLocal.php.template
rm package/app/app/configurations/apache/httpd.conf
mv package/app/app/configurations $RPM_BUILD_ROOT%{prefix}/app/
mv package/app/app/start $RPM_BUILD_ROOT%{prefix}/app
mv package/app/app/infra $RPM_BUILD_ROOT%{prefix}/app/
mv package/app/app/generator $RPM_BUILD_ROOT%{prefix}/app/
mv $RPM_BUILD_ROOT%{prefix}/app/generator/config.template.ini $RPM_BUILD_ROOT%{prefix}/app/generator/config.ini
mv package/app/app/OLD_PATHS $RPM_BUILD_ROOT%{prefix}/app/
mv package/app/app/admin_console $RPM_BUILD_ROOT%{prefix}/app/
mv package/app/app/alpha $RPM_BUILD_ROOT%{prefix}/app
mv package/app/app/deployment $RPM_BUILD_ROOT%{prefix}/app
mv package/app/app/api_v3 $RPM_BUILD_ROOT%{prefix}/app
mv package/app/app/batch $RPM_BUILD_ROOT%{prefix}/app
mv package/app/cache $RPM_BUILD_ROOT%{prefix}/app
mv package/app/app/clients $RPM_BUILD_ROOT%{prefix}/app
mv package/app/app/doc $RPM_BUILD_ROOT%{prefix}/app
mv package/app/app/scripts $RPM_BUILD_ROOT%{prefix}/app
mv package/app/app/plugins $RPM_BUILD_ROOT%{prefix}/app
mv package/app/app/service_config $RPM_BUILD_ROOT%{prefix}/app
mv package/app/app/symfony* $RPM_BUILD_ROOT%{prefix}/app
mv package/app/app/tests $RPM_BUILD_ROOT%{prefix}/app
mv package/app/app/ui_infra $RPM_BUILD_ROOT%{prefix}/app
mv package/app/app/vendor $RPM_BUILD_ROOT%{prefix}/app
mv package/app/web $RPM_BUILD_ROOT%{prefix}/
mv package/app/html5	$RPM_BUILD_ROOT%{prefix}/
mv package/app/apps $RPM_BUILD_ROOT%{prefix}/
mv package/app/dwh $RPM_BUILD_ROOT%{prefix}/
if [ %{_arch} = 'i386' -o %{_arch} = 'i686' ];then
	mv package/bin/linux/32bit/* $RPM_BUILD_ROOT%{prefix}/bin
else
	mv package/bin/linux/64bit/* $RPM_BUILD_ROOT%{prefix}/bin
fi
rm $RPM_BUILD_ROOT%{prefix}/bin/mediainfo
cd $RPM_BUILD_ROOT%{prefix}/bin
chmod +x run/*.sh $RPM_BUILD_ROOT%{prefix}/bin/sphinx/searchd 
cd -
install -m 644 %{SOURCE1} $RPM_BUILD_ROOT%{_sysconfdir}/httpd/conf.d/
install -m 644 %{SOURCE2} $RPM_BUILD_ROOT%{_sysconfdir}/logrotate.d/kaltura
install -m 644 %{SOURCE3} $RPM_BUILD_ROOT%{prefix}/app/configurations/sphinx/
install -m 644 %{SOURCE4} $RPM_BUILD_ROOT%{prefix}/app/alpha/config/
install -m 755 %{SOURCE5} $RPM_BUILD_ROOT%{_sysconfdir}/init.d/kaltura-searchd
install -m 600 %{SOURCE6} $RPM_BUILD_ROOT%{prefix}/app/admin_console/configs/application.ini.template
# override the original clear_cache.php which had calls to 'del' w/o verifying PHP_OS
install -m 755 %{SOURCE7} $RPM_BUILD_ROOT%{prefix}/app/scripts/clear_cache.php
echo -e "PREFIX=%{prefix}\nPRODUCT='Kaltura platform'\nVERSION=%{version}\n" > $RPM_BUILD_ROOT%{prefix}/app/configurations/kaltura.rc
%pre
# add kaltura user and attath it to the apache group
getent group apache >/dev/null || groupadd -g 48 -r %{kaltura_user}
getent passwd %{kaltura_user} >/dev/null || \
  useradd -r -u %{kaltura_uid} -g apache  -s /sbin/nologin \
    -d %{prefix} -c "Kaltura" %{kaltura_user}
exit 0

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)

%doc INSTALLATION.txt KALTURA-ON-PREM-EVALUATION-AGREEMENT.txt
%dir %{prefix}
%{prefix}
%config (noreplace)%{prefix}/app/configurations/*
%defattr(0660,root,apache,-)
%config (noreplace)%{prefix}/app/alpha/config/kConfLocal.php.template
%config (noreplace)%{prefix}/app/alpha/config/kConf.php
%defattr(-,root,root,-)
%defattr(0600,root,root,-)
%config (noreplace)%{prefix}/app/configurations/kaltura.rc
%config (noreplace)%{_sysconfdir}/httpd/conf.d/kaltura.conf
%config %{_sysconfdir}/logrotate.d/kaltura
%config (noreplace)%{prefix}/app/generator/config.ini
%{_sysconfdir}/init.d/kaltura-searchd
%defattr(0775,root,apache,-)
%{prefix}/log
%{prefix}/cache
%{prefix}/app/cache
%{prefix}/app/alpha/cache
%{prefix}/app/alpha/log

%post
cd %{prefix}/bin
ln -sf %{prefix}/bin/run/run-* .
cd -
/etc/init.d/httpd configtest
if [ $? -eq 0 ];then
	service httpd reload
else
	echo "\n**There seem to be a problem with your Apache configuration, please fix and restart**"
fi
#echo "Generating UI configuration..."
#cd %{prefix}/app/deployment/uiconf 
#php deploy_v2.php --ini=%{prefix}/web/flash/kmc/v4.2.14.9/config.ini 1>/dev/null
#service kaltura-searchd start
echo "Generating API configuration..."
cd %{prefix}/app/generator && ./generate.sh 1> /dev/null

# Open questions:
# - Should we direct output for post script to /dev/null?
# - OpenJDK - OK or not?
# - Postinstall script to setup and resetup DB params
# /opt/dwh/setup/dwh_setup.sh -h 127.0.0.1 -P 3306 -u etl -p etl -d /opt/kaltura/dwh
# cron
# sphinx
%changelog
* Wed Feb 29 2012 Jess Portnoy <jess.portnoy@kaltura.com> - 5.0.0-6
- Stricter permissions on config files
- Added /etc/kaltura.rc 
- Added dependency on rsync, curl and java-1.6.0-openjdk
* Wed Feb 22 2012 Jess Portnoy <jess.portnoy@kaltura.com> - 5.0.0-5
- Still work in progress...
* Tue Feb 15 2012 Jess Portnoy <jess.portnoy@kaltura.com> - 5.0.0-4
- Initial release
