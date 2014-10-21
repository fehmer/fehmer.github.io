# DocPad Configuration File
# http://docpad.org/docs/config

cheerio = require('cheerio')
url = require('url')

Array::unique = ->
    output = {}
    output[@[key]] = @[key] for key in [0...@length]
    value for key, value of output


docpadConfig = {
    growl: false 


    templateData:
        moment: require('moment')

        site:
            # The production url of our website
            url: "http://www.fehmer.info"

            # The default title of our website
            title: "Christian Fehmer"

            # cache-busting timestamp
            timestamp: new Date().getTime()

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
        
        # -----------------------------
        # Helper Functions

        # Get the prepared site/document title
        # Often we would like to specify particular formatting to our page's title
        # we can apply that formatting here
        getPreparedTitle: ->
            # if we have a document title, then we should use that and suffix the site's title onto it
            if @document.title
                "#{@document.title} - #{@site.title}"
                # if our document does not have it's own title, then we should just use the site's title
            else
                @site.title

        homeClass: -> if @document.name is 'index.html' then 'home'
        isBlog: -> if @document.name is 'blog.html' or  @document.layout is 'posts' then true else false

        getTagUrl: (tag) ->
            slug = tag.toLowerCase().replace(/[^a-z0-9]/g, '-').replace(/-+/g, '-').replace(/^-|-$/g, '')
            "/tags/#{slug}/"

        getPageUrlWithHostname: ->
            "#{@site.url}#{@document.url}"

        getIdForDocument: (document) ->
            hostname = url.parse(@site.url).hostname
            date = document.date.toISOString().split('T')[0]
            path = document.url
            "tag:#{hostname},#{date},#{path}"

        fixLinks: (content) ->
            baseUrl = @site.url
            regex = /^(http|https|ftp|mailto):/

            $ = cheerio.load(content)
            $('img').each ->
                $img = $(@)
                src = $img.attr('src')
                $img.attr('src', baseUrl + src) unless regex.test(src)
            $('a').each ->
                $a = $(@)
                href = $a.attr('href')
                $a.attr('href', baseUrl + href) unless regex.test(href)
            $.html()

        getDuration: (duration) ->
            return if not duration?
            d = duration.toString()
            if d.substring(0,2) is '->'
                return '(till '+ d.substring(3,d.length)+ ')'
            return '('+duration+' months)'

        pyears: () ->
            foo = @getCollection('documents').findAllLive({relativeDirPath: 'projects'}, [date: -1]).toJSON().map (doc) -> doc.year
            return foo.unique().sort().reverse()
            
        projects: (selected) ->
            return @getCollection('documents').findAllLive({relativeDirPath: 'projects', year: $eq: selected}, [date: -1]).toJSON()
            

    collections:
        pages: ->
            @getCollection("html").findAllLive({isPage:true},[order:1])

        posts: ->
            @getCollection('documents').findAllLive({relativeDirPath: 'posts'}, [date: -1])

        cleanurls: ->
            @getCollection('html').findAllLive(skipCleanUrls: $ne: true)

       

    plugins:
        tags:
            findCollectionName: 'posts'
            extension: '.html'
            injectDocumentHelper: (document) ->
                document.setMeta(
                    layout: 'tags'
                )
        dateurls:
            cleanurl: true
            trailingSlashes: true
            keepOriginalUrls: false
            collectionName: 'posts'
            dateIncludesTime: true
        paged:
            cleanurl: true
            startingPageNumber: 2
        cleanurls:
            trailingSlashes: true
            collectionName: 'cleanurls'
}

# Export the DocPad Configuration
module.exports = docpadConfig
