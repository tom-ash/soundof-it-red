# frozen_string_literal: true

module SoundofIt
  module Api
    class Base < ::Api::Base
      helpers do
        def site_name
          @site_name ||= SKILLFIND_TECH_NAME
        end

        def constantized_site_name
          @constantized_site_name ||= SKILLFIND_TECH_NAME_CONSTANTIZED_NAME
        end

        def image
          @image ||= SKILLFIND_TECH_IMAGE
        end

        def domain_url
          @domain_url ||= SKILLFIND_TECH_URL
        end

        def langs
          @langs ||= SKILLFIND_TECH_NAME_LANGS
        end

        def sitemaps
          [
            ::SoundofIt::Api::Tracks::Root::Sitemap,
            ::SoundofIt::Api::Tracks::Visitor::Contact::Sitemap,
            ::SoundofIt::Api::Tracks::Visitor::TermsOfService::Sitemap,
            ::SoundofIt::Api::Tracks::Visitor::CookiesPolicy::Sitemap,
            ::SoundofIt::Api::Tracks::Visitor::PrivacyPolicy::Sitemap,
            ::SoundofIt::Api::Tracks::Visitor::PrivacySettings::Sitemap
          ]
        end

        def bucket
          @bucket ||= ENV['AWS_S3_SOUNDOFIT_BUCKET']
        end
      end

      mount ::Api::Sitemap => 'sitemap'
      mount ::SoundofIt::Api::Sync => 'sync'
      mount ::SoundofIt::Api::Methods::Job::Create::AsUser => 'job/create/as-user'
    end
  end
end
