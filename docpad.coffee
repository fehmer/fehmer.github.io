# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig = {
	templateData:
        site:
            title: "Christian Fehmer"

        sections: ['home', 'about', 'projects', 'skills', 'hire']

        labels:
        	home: 'Hello!'
        	about: 'Über mich'
        	projects: 'Projekte'
        	skills: 'Skills'
        	hire: 'Hire!'

        getPreparedTitle: -> if @document.title then "#{@document.title} - #{@site.title}" else @site.title
        homeClass: -> if @document.name is 'index.html' then 'home'

    collections:
        pages: ->
            @getCollection("html").findAllLive({isPage:true},[order:1])
}

# Export the DocPad Configuration
module.exports = docpadConfig