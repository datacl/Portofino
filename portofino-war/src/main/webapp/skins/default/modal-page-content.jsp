<%@ page import="com.manydesigns.portofino.logic.SecurityLogic"
%><%@ page import="java.util.Map"
%><%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes-dynattr.tld"
%><%@ taglib tagdir="/WEB-INF/tags" prefix="portofino"
%><%@ taglib prefix="mde" uri="/manydesigns-elements"
%><stripes:layout-definition>
    <jsp:useBean id="actionBean" scope="request"
             type="com.manydesigns.portofino.pageactions.AbstractPageAction"/>
    <c:if test="${empty formActionUrl}">
        <c:set var="formActionUrl" value="${dispatch.originalPath}" />
    </c:if>
    <stripes:form action="${formActionUrl}" method="post" enctype="multipart/form-data">
        <div class="contentHeader">
            <stripes:layout-component name="contentHeader">
                Portlet page header
            </stripes:layout-component>
        </div>
        <div class="contentBody">
            <div class="portletWrapper">
                <div class="portlet">
                    <mde:sessionMessages/>
                    <div class="portletHeader">
                        <stripes:layout-component name="portletHeader">
                            <div>
                                <div class="portletTitle">
                                    <h1>
                                    <stripes:layout-component name="portletTitle">
                                        portletTitle
                                    </stripes:layout-component>
                                    </h1>
                                </div>
                                <div class="portletHeaderButtons">
                                    <stripes:layout-component name="portletHeaderButtons" />
                                </div>
                            </div>
                            <div class="portletHeaderSeparator"></div>
                        </stripes:layout-component>
                    </div>
                    <div class="portletBody">
                        <stripes:layout-component name="portletBody">
                            Portlet body
                        </stripes:layout-component>
                    </div>
                    <div class="portletFooter">
                        <stripes:layout-component name="portletFooter">
                        </stripes:layout-component>
                    </div>
                </div>
            </div>
        </div>
        <div class="contentFooter">
            <stripes:layout-component name="contentFooter">
                Portlet page footer
            </stripes:layout-component>
        </div>
    </stripes:form>
</stripes:layout-definition>