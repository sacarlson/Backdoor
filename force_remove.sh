# note must run as sudo su
# this is when the install messes up and can't be removed normaly with
# apt-get remove packagename
#debconf-show packagename
#debconf-show $1
#echo PURGE | debconf-communicate packagename
#echo PURGE | debconf-communicate $1
#sleep 3
#debconf-show mini-isp-1.0-1
$package_name="backdoor"
$version="-1.0-2"
sudo mv /var/lib/dpkg/info/"$package_name"* /tmp/
#sudo mv /var/lib/dpkg/info/packagename* /tmp/
sudo dpkg --purge --force-remove-reinstreq "$package_name""$version"
echo PURGE | debconf-communicate "$package_name""$version"
  
