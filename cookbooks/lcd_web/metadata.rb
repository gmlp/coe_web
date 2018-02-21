name 'lcd_web'
maintainer 'Gonzalo Lopez'
maintainer_email 'gonzalom.lopez@softtek.com'
license 'AGPL-1.0'
description 'Installs/Configures lcd_web'
long_description 'Installs/Configures lcd_web'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)
supports 'redhat'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://bitbucket.org/softtekcoe/coe_web/issues' if respond_to?(:issues_url)

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://bitbucket.org/softtekcoe/coe_web' if respond_to?(:source_url)