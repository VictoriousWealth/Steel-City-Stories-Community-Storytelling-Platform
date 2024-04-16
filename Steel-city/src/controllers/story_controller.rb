require "require_all"

get "/create-story" do
  erb :writingstorypage
end

post "/submit-story" do
    @title = params.fetch("story-title", "")
    @body = params.fetch("story-content", "")
    @genre = params.fetch("genre","")
    @blurb = params.fetch("blurb-content","")
    @price = params.fetch("price","")
    @error = nil
    if @price.to_f==0.0
        @error="Invalid price"
    end
    begin
      db = SQLite3::Database.new 'database.sqlite3'
        story=Story.new
        numstories=Story.all.count()
        story.storyid=numstories+1
        story.title=@title
        story.content=@body
        story.price=@price.to_f
        story.blurb=@blurb
        story.genre=@genre
        story.releasedate=Date.today.strftime("%d/%m/%y")
        story.writerid=session["currentuser"]
        story.save_changes
        session["logged_in"] = true
    rescue SQLite3::Exception => e
      @error = "Database error: #{e.message}"
    ensure
      db.close if db
    end
    #should redirect to relevant story page
    erb :writingstorypage
end