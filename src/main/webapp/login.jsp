<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" import="oracle.e1.mobile.authenticator.JDEADFMobileLoginModule" pageEncoding="UTF-8"%>。

<%
  response.setContentType("text/html; charset=UTF-8");
  String acceptLanguage = request.getHeader("accept-language");
  String language = null;
  String country = null;
  
  // 1. en-us
  // 2. en-us,fr-fr;q=0.5
  // 3. en
  if (acceptLanguage != null && acceptLanguage.length() != 0) {
    int index1 = acceptLanguage.indexOf(',');
    if (index1 > -1) {
      acceptLanguage = acceptLanguage.substring(0, index1);    
    }
    
    int index2 = acceptLanguage.indexOf('-');
    if (index2 > -1) {
      language = acceptLanguage.substring(0, index2);
      country = acceptLanguage.substring(index2+1).toUpperCase();
    }
    else {
      language = acceptLanguage;
    }
  }

  if (language == null)
  {
     language = "en";
  }
  if (country == null)
  {
     country = "US";
  }
  
  java.util.Locale locale = new java.util.Locale(language, country);
  java.util.ResourceBundle res = java.util.ResourceBundle.getBundle("oracle.e1.mobile.resource.LoginResource", locale);
  
  //System.out.println("lang=" + language + ",country=" + country);
  //System.out.println("user=" + res.getString("USERNAME"));
  
  // Load default environment and role
  String env = System.getProperty("DEFAULT_ENV");
  if (env == null)
    env = "";
  
  String role = System.getProperty("DEFAULT_ROLE");
  if (role == null)
    role = "";
%>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"></meta>
    <meta name="viewport"
          content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0;"/>
    <title>login</title>        
    <script type="text/javascript">
      function checkForm(form) {
       setTimeout(function(){showProcessing()},750); 
        var username = document.getElementById("username").value;

          if (document.getElementById("env")) {
              // Environment and role fields displayed
              var env = document.getElementById("env").value;
              var role = document.getElementById("role").value;
              if (env.value == "") {
                  return false;
              }
              if (role.value == "") {
                  return false;
              }

              document.getElementById("j_username").value = "DN=" + username + ",ENV=" + env + ",ROLE=" + role;
          }
          else {
              // Environment and role fields note displayed
              document.getElementById("j_username").value = username;
          }

          return true;
      }

      function setFocus() {
          document.getElementById("username").focus();
      }

      window.onload = setFocus;
      
       function showProcessing(){
             var processing = document.getElementById("processing");

            processing.style.display='block';
        }       
    </script>    
    
  </head>
  <body style="background-color:rgb(1,87,158); width:100%; margin: 0 0 0 0;" onload="checkDevice();">   
    <!-- Logo-->
    <table  cellpadding="0" cellspacing="0" border="0" summary="" style="background-color:white; width:100%; margin:10px 0px 0px 0px;">
      <tr >
        <td>
          <img src="public_images/O_JD_Edwards_clr.gif" alt="Oracle JD Edwards" style="height:55px; width:117px; "/>
        </td>
        <td width="100%"
            style="text-align:center; color:Black; font-weight:bold; font-size:large; font-family:Arial, Helvetica, sans-serif;"><%=res.getString("MOBILE_SOLUTION")%></td>
      </tr>       
    </table>
    <!--EULA LINK-- Absolute positioning to the bottom of the page-->    
    
    <a style=" text-decoration:none;display:block; position:absolute; top:440px; left:10px; font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt;font-weight:normal; color:white;" href="EULA.jsp"><%=res.getString("ABOUT")%></a>
    
    <div id="processing" style="z-index:9999; display:none;position: fixed; left: 0px; top: 0px; width: 100%; height: 100%;">
             <table width="100%" height="100%" align="center" valign="center"><tr align="center"><td>            
            <img src="public_images/activityindicator.gif" style="height:50px;width:50px;background-color:white; -webkit-border-radius: 10px;border:thin solid #808080;padding:3px 3px 3px 4px"/>
            </td></tr></table>            
            </div>
    <form method="POST" action="j_security_check"
          onsubmit="return checkForm(this)">
        <div id="top" align="center">        
          <fieldset style="background-color:white; border-color:rgb(1,87,158); border-radius:10px;  margin:10px;">
            <div>
              <table border="0" cellspacing="0" summary=""
                     cellpadding="0">
                <tbody>
                  <tr>
                    <td style="vertical-align:top;" colspan="1">
                      <table border="0" cellspacing="0" summary=""
                             cellpadding="0">
                        <tbody>
                          <%        
                        String error = (String)request.getParameter("error");
                        if ("true".equalsIgnoreCase(error) ){
                        %>
                          <tr>
                            <td>&nbsp;</td>
                          </tr>
                          <tr>
                            <td nowrap="noWrap" colspan="2">
                              <div>
                                <div>
                                  <h1 align="center"
                                      style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:13pt;color:#669966;font-weight:bold;margin:0px;border-color:#CCCCCC;border-width:0px 0px 1px 0px;border-style:solid;vertical-align:bottom;margin:0px 0px 0px 0px;">
                                    <span style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:13pt;font-weight:bold;padding:0px 0px 0px 0px;margin:0px;color:#cc0000;">
                                      <%=res.getString("LOGIN_ERROR")%></span>
                                  </h1>
                                </div>
                              </div>
                            </td>
                          </tr>
                          <%
                        }
                        %>
                          <tr style="color:#000000;">
                            <td>&nbsp;</td>
                          </tr>
                          <tr style="color:#000000;">
                            <td style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt;text-align:left;color:#000000;padding:0px 8px 0px 0px;font-weight:normal;"
                                nowrap="noWrap">
                              <span style="DISPLAY: none">
                                <a title="Error">X</a></span>&nbsp;<label>
                                <%=res.getString("USERNAME")%>
                                :
                              </label>
                            </td>
                            <td style="padding:1px 0px;" valign="top"
                                nowrap="noWrap">
                              <input id="username"
                                     style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt;font-weight:normal;color:#000000;"
                                     maxlength="20" size="16" type="text"
                                     name="username"></input>
                               
                              <input type="hidden" name="j_username"
                                     id="j_username" maxlength="100"/>
                              <div style="padding:1px 0px;">
                                <span style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:8pt;font-weight:normal;color:#cc0000;"></span>
                              </div>
                            </td>
                          </tr>
                          <tr style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt;font-weight:normal;color:#000000;">
                            <td style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt;text-align:left;color:#000000;padding:0px 8px 0px 0px;font-weight:normal;"
                                nowrap="noWrap">
                              <span style="DISPLAY: none">
                                <a title="Error">X</a></span>&nbsp;<label>
                                <%=res.getString("PASSWORD")%>
                                :
                              </label>
                            </td>
                            <td style="padding:1px 0px;" valign="top"
                                nowrap="noWrap">
                              <input id="j_password"
                                     style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt;font-weight:normal;color:#000000;"
                                     maxlength="10" size="16" type="password"
                                     name="j_password"></input>
                              <div style="padding:1px 0px;">
                                <span style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:8pt;font-weight:normal;color:#cc0000;"></span>
                              </div>
                            </td>
                          </tr>
                          <%
                        if ("true".equalsIgnoreCase(System.getProperty("DISPLAY_ENV_ROLE")) ){
                        %>
                          <tr style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt;font-weight:normal;color:#000000;">
                            <td style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt;text-align:left;color:#000000;padding:0px 8px 0px 0px;font-weight:normal;"
                                nowrap="noWrap">
                              <span style="DISPLAY: none">
                                <a title="Error">X</a></span>&nbsp;<label>
                                <%=res.getString("ENV")%>
                                :
                              </label>
                            </td>
                            <td style="padding:1px 0px;" valign="top"
                                nowrap="noWrap">
                              <input id="env"
                                     style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt;font-weight:normal;color:#000000;"
                                     maxlength="10" size="16" type="text"
                                     name="env" value="<%=env%>"></input>
                              <div style="padding:1px 0px;">
                                <span style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:8pt;font-weight:normal;color:#cc0000;"></span>
                              </div>
                            </td>
                          </tr>
                          <tr style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt;font-weight:normal;color:#000000;">
                            <td style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt;text-align:left;color:#000000;padding:0px 8px 0px 0px;font-weight:normal;"
                                nowrap="noWrap">
                              <span style="DISPLAY: none">
                                <a title="Error">X</a></span>&nbsp;<label>
                                <%=res.getString("ROLE")%>
                                :
                              </label>
                            </td>
                            <td style="padding:1px 0px;" valign="top"
                                nowrap="noWrap">
                              <input id="role"
                                     style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt;font-weight:normal;color:#000000;"
                                     maxlength="10" size="16" type="text"
                                     name="role" value="<%=role%>"></input>
                              <div style="padding:1px 0px;">
                                <span style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:8pt;font-weight:normal;color:#cc0000;"></span>
                              </div>
                            </td>
                          </tr>
                          <%
                        } 
                        %>
                          <tr>
                            <td>&nbsp;</td>
                          </tr>
                          <tr>
                            <td>&nbsp;</td>
                            <td colspan="2"
                                style="align:center; padding:1px 0px;">
                              <input type="submit" name="submit"  
                                     style="font-family:Arial,Helvetica,Geneva,sans-serif;font-size:10pt;font-weight:normal;white-space:nowrap;"
                                     value='<%=res.getString("LOGIN")%>'/>
                            </td>                            
                          </tr>
                        </tbody>
                      </table>
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>
          </fieldset>
        </div>
    </form>
  </body>
</html>