# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig = {

	
	growl: false 

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

        levelLabels: ['basic','advanced','professional','expert']

        skills: 
            'Java':
                level: 4
                sub:
                    'JEE':  4
                    'Hibernate': 3
                    'Spring': 4
                    'JSP':2
                    'JSF':1
            'Hibernate':
                level: 3
            'Node.js':
                level: 2
            'DocPad':
                level: 1
        
        getPreparedTitle: -> if @document.title then "#{@document.title} - #{@site.title}" else @site.title
        homeClass: -> if @document.name is 'index.html' then 'home'

    collections:
        pages: ->
            @getCollection("html").findAllLive({isPage:true},[order:1])
}

# Export the DocPad Configuration
module.exports = docpadConfig
