<%@ page import="grails.util.GrailsNameUtils" %>


<div class="form-group ${errors ? 'has-error' : ''}" controller="relationSelect">
	<label for="${property}-input">
		${label}
		<g:if test="${required}">
			<sup class="mandatory">*</sup>
		</g:if>

		<span style="margin-left: 10px;">
			<a class="rel-select" href="javascript:" resource="${grails.util.GrailsNameUtils.getPropertyNameRepresentation(type)}" property="${property}">Select</a> /
			<a class="rel-remove" href="javascript:">Clear</a>
		</span>

	</label>
	${widget}
</div>
