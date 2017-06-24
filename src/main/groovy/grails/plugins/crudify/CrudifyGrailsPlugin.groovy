package grails.plugins.crudify

import grails.plugins.*
import org.springframework.jdbc.core.JdbcTemplate

class CrudifyGrailsPlugin extends Plugin {

	def grailsVersion = "3.2.4 > *"
	def pluginExcludes = [
			"grails-app/views/error.gsp"
	]

	def title = "Crudify"
	def author = "Your name"
	def authorEmail = ""
	def description = "Cruify"
	def profiles = ['web']

	Closure doWithSpring() {
		{ ->
			jdbcTemplate(JdbcTemplate, ref("dataSource"))
		}
	}


}
