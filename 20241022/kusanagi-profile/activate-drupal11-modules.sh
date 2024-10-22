# Install drupal modules via composer
name=$1

 pushd ./${name}
 pwd

drush pm:install ban -y
drush pm:install layout_builder -y
drush pm:install layout_builder -y
drush pm:install layout_discovery -y
drush pm:install media -y
drush pm:install media_library -y
drush pm:install settings_tray -y
drush pm:install syslog -y
drush pm:install admin_toolbar -y
drush pm:install admin_toolbar_tools -y
drush pm:install admin_toolbar_search -y
drush pm:install field_group -y
drush pm:install datetime_range -y
drush pm:install telephone -y
drush pm:install twig_tweak -y
drush pm:install group -y
drush pm:install gnode -y
drush pm:install group_support_revisions -y

#Development
drush pm:install devel -y
drush pm:install devel_generate -y
#Mail
drush pm:install symfony_mailer -y
drush pm:install mailsystem -y
#Cron
drush pm:install ultimate_cron -y
drush pm:install queue_ui -y
#SNS
drush pm:install social_api -y
drush pm:install social_auth -y
drush pm:install social_auth_google -y
#language
drush pm:install config_translation -y
drush pm:install content_translation -y
drush pm:install locale -y
drush pm:install language -y
#API
drush pm:install basic_auth -y
drush pm:install jsonapi -y
drush pm:install rest -y
drush pm:install serialization -y
#Theme
drush theme:enable bootstrap5
drush config:set system.theme default bootstrap5 -y
