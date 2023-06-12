class Builders::StampFigUrl < SiteBuilder
  def build
    helper :stamp_fig_url do |path|
      "/assets/images/stamps/#{path}"
    end
  end
end
