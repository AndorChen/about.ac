class Builders::FigureUrl < SiteBuilder
  def build
    helper :figure_url do |path|
      "/assets/images/figures/#{path}"
    end
  end
end
