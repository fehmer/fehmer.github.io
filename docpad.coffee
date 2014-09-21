# DocPad Configuration File
# http://docpad.org/docs/config

# Define the DocPad Configuration
docpadConfig = {

    
    growl: false 


    templateData:
        moment: require('moment')

        site:
            title: "Christian Fehmer"

        sections: ['home', 'about', 'projects', 'blog', 'hire']

        labels:
            home: 'Hello!'
            about: 'Über mich'
            projects: 'Projekte'
            skills: 'Skills'
            blog: 'Blog'
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
        getTagUrl: (tag) ->
            slug = tag.toLowerCase().replace(/[^a-z0-9]/g, '-').replace(/-+/g, '-').replace(/^-|-$/g, '')
            "/tags/#{slug}/"

    collections:
        pages: ->
            @getCollection("html").findAllLive({isPage:true},[order:1])
        posts: ->
            @getCollection('documents').findAllLive({relativeDirPath: 'posts'}, [date: -1])
}

# Export the DocPad Configuration
module.exports = docpadConfig
