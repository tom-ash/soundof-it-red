# frozen_string_literal: true

SOUNDOF_IT_NAME = 'soundof.it'
SOUNDOF_IT_NAME_CONSTANTIZED_NAME = 'SoundofIt'
SOUNDOF_IT_NAME_APEX_DOMAIN = 'soundof.it'
SOUNDOF_IT_NAME_ROOT_DOMAIN = SOUNDOF_IT_NAME_APEX_DOMAIN
SOUNDOF_IT_NAME_LANGS = %i[en pl].freeze
SOUNDOF_IT_URL = "https://#{SOUNDOF_IT_NAME_ROOT_DOMAIN}"
SOUNDOF_IT_S3 = ENV['AWS_S3_SOUNDOFIT_BUCKET']
SOUNDOF_IT_IMAGE = 'https://soundofit.s3.eu-central-1.amazonaws.com/soundof.it.jpeg'

MAPAWYNAJMU_PL_NAME = 'mapawynajmu.pl'
MAPAWYNAJMU_PL_CONSTANTIZED_NAME = 'MapawynajmuPl'
MAPAWYNAJMU_PL_APEX_DOMAIN = 'mapawynajmu.pl'
MAPAWYNAJMU_PL_ROOT_DOMAIN = MAPAWYNAJMU_PL_APEX_DOMAIN
MAPAWYNAJMU_PL_NAME_LANGS = %i[pl en].freeze
MAPAWYNAJMU_PL_URL = "https://#{MAPAWYNAJMU_PL_ROOT_DOMAIN}"
MAPAWYNAJMU_PL_S3 = ENV['AWS_S3_MAPAWYNAJMUPL_BUCKET']
MAPAWYNAJMU_PL_IMAGE = 'https://mapawynajmupl.s3.eu-central-1.amazonaws.com/assets/images/mapawynajmupl.jpg'

# DEV
SOUNDOF_IT_DEV_URL = 'http://local.soundof.it:8080'
MAPAWYNAJMU_PL_DEV_URL = 'http://local.mapawynajmu.pl:8080'
