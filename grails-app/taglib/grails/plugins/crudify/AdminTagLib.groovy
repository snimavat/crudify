package grails.plugins.crudify

/**
 * Created by sudhir on 12/03/17.
 */
class AdminTagLib {
	static namespace = "admin"

	Closure link = {attrs, body ->
		def linkParams = attrs
		linkParams.namespace = "admin"
		linkParams.params = attrs.params ?: [:]
		linkParams.params.domainClass = attrs.domain ?: params.domainClass
		out << g.link(linkParams, body)
	}
}
