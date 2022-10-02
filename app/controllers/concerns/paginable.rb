module Paginable
  extend ActiveSupport::Concern

  included do
    before_action :set_page, only: [:index]
  end

  private

  def set_page
    @page = params[:page] || 1
    @per_page = params[:per_page] || 20
  end
end