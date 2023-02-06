# frozen_string_literal: true

module JsonRenderable
  extend ActiveSupport::Concern

  def render_ok
    render json: {}, status: :ok
  end

  def render_result(entity, entity_blueprint, status: 200, options: {})
    render json: entity_blueprint.render(entity, options), status:
  end
end
