package grails.plugins.crudify

import grails.plugins.*
import org.springframework.jdbc.core.JdbcTemplate

class CrudifyGrailsPlugin extends Plugin {

    // the version or versions of Grails the plugin is designed for
    def grailsVersion = "3.2.4 > *"
    // resources that are excluded from plugin packaging
    def pluginExcludes = [
        "grails-app/views/error.gsp"
    ]

    // TODO Fill in these fields
    def title = "Crudify" // Headline display name of the plugin
    def author = "Your name"
    def authorEmail = ""
    def description = "Cruify"
    def profiles = ['web']

    // URL to the plugin's documentation
    def documentation = "http://grails.org/plugin/crudify"


    Closure doWithSpring() { {->
          jdbcTemplate(JdbcTemplate, ref("dataSource"))
        }
    }

    void doWithDynamicMethods() {
        // TODO Implement registering dynamic methods to classes (optional)
    }

    void doWithApplicationContext() {
        // TODO Implement post initialization spring config (optional)
    }

    void onChange(Map<String, Object> event) {
        // TODO Implement code that is executed when any artefact that this plugin is
        // watching is modified and reloaded. The event contains: event.source,
        // event.application, event.manager, event.ctx, and event.plugin.
    }

    void onConfigChange(Map<String, Object> event) {
        // TODO Implement code that is executed when the project configuration changes.
        // The event is the same as for 'onChange'.
    }

    void onShutdown(Map<String, Object> event) {
        // TODO Implement code that is executed when the application shuts down (optional)
    }
}
