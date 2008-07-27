# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'ciuchcia'

task :default => 'spec:run'

PROJ.name = 'ciuchcia'
PROJ.version = Ciuchcia::VERSION
PROJ.authors = 'Kacper Cieśla'
PROJ.email = 'kacper.ciesla@gmail.com'
PROJ.url = 'FIXME (project homepage)'
PROJ.rubyforge.name = 'ciuchcia'

PROJ.spec.opts << '--color'

depend_on 'rails'

# EOF
