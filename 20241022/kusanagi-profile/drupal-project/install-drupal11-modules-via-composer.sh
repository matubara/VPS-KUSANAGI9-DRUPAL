# Install drupal modules via composer
name=$1

 pushd ./${name}
 pwd

composer require 'drupal/admin_toolbar:^3.5'
#composer require 'drupal/examples:^4.0'
composer require 'drupal/mailsystem:^4.5'
composer require 'drupal/email_validator:^2.4'
composer require 'drupal/symfony_mailer:^1.5'
composer require 'drupal/devel:^5.2'
composer require 'drupal/social_api:^4.0'
composer require 'drupal/social_auth:^4.1'
composer require 'drupal/social_auth_google:^4.0'
composer require 'drupal/twig_tweak:^3.4'
composer require 'drupal/ultimate_cron:^2.0@alpha'
composer require 'drupal/group:^3.3'

#composer require 'drupal/multiselect:^2.0@beta'

composer require 'drupal/field_group:^3.6'
composer require 'drupal/queue_ui:^3.2'
composer require openai-php/client

composer require 'drupal/bootstrap5:^4.0'
popd
