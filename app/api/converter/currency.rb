module Converter
  class Currency < Grape::API #this class responds to api request and for that we need to have resources.
    version 'v1', using: :path
    format :json #to get json response
    # # format :xml to get xml response
    rescue_from :all  #To show errors not in the rails way.

    error_formatter :json, lambda { |message, backtrace, options, env | #error format
      {
          status: "failed",
          message: "no conversion found for currency",
          error_code: 123
      }
    }

    helpers do
      def get_exchange_rate(currency)
        case currency
          when "NTD"
            30
          else
            raise StandardError.new "no conversion found for currency #{currency}"
          end
      end
    end

    resource :converter do
      params do
        requires :amount, type: Float
        requires :to_currency, type: String
      end

      get :exchange do  #http://localhost:3000/api/v1/converter/exchange?amount=4.5&to_currency=NTD
       converted_amount = params[:amount] * get_exchange_rate(params[:to_currency])
        { amount: converted_amount , currency: params[:to_currency] }
      end

      get :report do #http
        {amount: "2"}
      end
    end

  end
end