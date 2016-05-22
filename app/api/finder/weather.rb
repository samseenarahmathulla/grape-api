module Finder
  class Weather < Grape::API
  version 'v1', using: :path
    format :json
    rescue_from :all

    helpers do
      def get_weather(place)
        case place
          when "s"
            30
          else
            raise StandardError.new "Weather reports of #{place} have not been updated."
        end
      end

    end


    resource :finder do
      params do
        requires :place, type: String
      end

      get :climate_report do #http://localhost:3000/finderapi/v1/finder/climate_report?place=s
        {
            place: params[:place],
            weather: get_weather(params[:place])
        }
      end
    end
  end
end