#Deleted the vendor folder
rm ../vendor -rf
#Deleted composer.lock
rm ../composer.lock -f
#lando composer clearcache
cd ..
composer clearcache
#lando composer install
composer install
#lando drush updatedb

