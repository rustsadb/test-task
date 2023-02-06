# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ErrorsHandlerable
  include DryValidatable
  include JsonRenderable
end
