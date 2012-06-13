<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes-dynattr.tld"
%><%@ taglib prefix="mde" uri="/manydesigns-elements"
%><%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
%><%@ taglib tagdir="/WEB-INF/tags" prefix="portofino" %>
<stripes:layout-render name="/skins/default/admin-page.jsp">
    <jsp:useBean id="actionBean" scope="request" type="com.manydesigns.portofino.actions.admin.appwizard.ApplicationWizard"/>
    <stripes:layout-component name="pageTitle">
        Step 1. Connect to your database
    </stripes:layout-component>
    <stripes:layout-component name="contentHeader">
        <portofino:buttons list="create-connection-provider" cssClass="contentButton" />
    </stripes:layout-component>
    <stripes:layout-component name="portletTitle">
        Step 1. Connect to your database
    </stripes:layout-component>
    <stripes:layout-component name="portletBody">
        <mde:sessionMessages />
        <script type="text/javascript">
            function changeSPForm() {
                $("#jndiCPForm").toggle();
                $("#jdbcCPForm").toggle();
            }
        </script>
        Connection type:
        <ul>
            <li><input id="jdbc_radio" type="radio" value="JDBC"
                       name="connectionProviderType"
                       <%= actionBean.isJdbc() ? "checked='checked'" : "" %>
                       onchange="changeSPForm();"
                    />
                <label for="jdbc_radio">JDBC</label></li>
            <li><input id="jndi_radio" type="radio" value="JNDI"
                       name="connectionProviderType"
                       <%= actionBean.isJndi() ? "checked='checked'" : "" %>
                       onchange="changeSPForm();"/>
                <label for="jndi_radio">JNDI</label></li>
        </ul>
        <div id="jndiCPForm" style='display: <%= actionBean.isJndi() ? "inherit" : "none" %>'>
            <mde:write name="actionBean" property="jndiCPForm"/>
        </div>
        <div id="jdbcCPForm" style='display: <%= actionBean.isJdbc() ? "inherit" : "none" %>'>
            <mde:write name="actionBean" property="jdbcCPForm"/>
        </div>

        <label for="advanced_checkbox">Show advanced options</label> <input id="advanced_checkbox" type="checkbox" name="advanced" />
    </stripes:layout-component>
    <stripes:layout-component name="contentFooter">
        <portofino:buttons list="create-connection-provider" cssClass="contentButton" />
    </stripes:layout-component>
</stripes:layout-render>