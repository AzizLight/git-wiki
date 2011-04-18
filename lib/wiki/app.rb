module GitWiki
  class App < Sinatra::Base

    configure do
      set :app_file, __FILE__
      set :root, File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))

      enable :sessions
      set :session_secret, "N0m d3 D13u d3 put41n d3 60rd31 d3 m3rd3 d3 s4l0pEri3 dE conN4rd d'EnculE d3 t4 m3r3"

      set :auth do |bool|
        condition do
          redirect '/login' unless logged_in?
        end
      end
    end

    helpers do
      def logged_in?
        not @user.nil?
      end
    end

    error PageNotFound do
      page = request.env["sinatra.error"].name
      redirect "/#{page}/edit"
    end

    before do
      content_type "text/html", :charset => "utf-8"
      @user = session[:user]
    end

    get "/login/?" do
      erb :login
    end

    post "/login" do
      user = User.get
      if user.authenticate(params[:username], params[:password])
        session[:user] = params[:username]
      else
        # Tell the user to fuck off, FAILED TO LOG IN!
      end

      redirect '/' + GitWiki.homepage
    end

    get "/logout" do
      session[:user] = nil
      redirect "/" + GitWiki.homepage
    end

    get "/" do
      redirect "/" + GitWiki.homepage
    end

    get "/pages" do
      @pages = Page.find_all
      erb :list
    end

    get "/:page/edit", :auth => true do
      @page = Page.find_or_create(params[:page])
      erb :edit
    end

    get "/:page" do
      @page = Page.find(params[:page])
      erb :show
    end

    post "/:page" do
      @page = Page.find_or_create(params[:page])
      @page.update_content(params[:body])
      redirect "/#{@page}"
    end

    private
      def title(title=nil)
        @title = title.to_s unless title.nil?
        @title
      end

      def list_item(page)
        %Q{<a class="page_name" href="/#{page}">#{page.name}</a>}
      end
  end
end
