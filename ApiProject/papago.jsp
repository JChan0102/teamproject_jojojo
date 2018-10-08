<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.DataOutputStream"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="application/JSON; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
   <%
      String clientId = "u_yEGZ03Z44nd5tL7bxy";// 애플리케이션 클라이언트 아이디값";
      String clientSecret = "3FUSkb7iAU";// 애플리케이션 클라이언트 시크릿값";
      try {
         //System.out.println(request.getParameter("id"));
         String text = URLEncoder.encode(request.getParameter("id"), "UTF-8");
         String apiURL = "https://openapi.naver.com/v1/language/translate";
         URL url = new URL(apiURL);
         HttpURLConnection con = (HttpURLConnection) url.openConnection();

         con.setRequestMethod("POST");
         con.setRequestProperty("X-Naver-Client-Id", clientId);
         con.setRequestProperty("X-Naver-Client-Secret", clientSecret);

         // post request
         String postParams = "source=ko&target=en&text=" + text;

         con.setDoOutput(true);
         DataOutputStream wr = new DataOutputStream(con.getOutputStream());

         wr.writeBytes(postParams);
         wr.flush();
         wr.close();

         int responseCode = con.getResponseCode();
         BufferedReader br;

         if (responseCode == 200) { // 정상 호출
            br = new BufferedReader(new InputStreamReader(con.getInputStream()));
         } else { // 에러 발생
            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
         }
         String inputLine;
         StringBuffer responsea = new StringBuffer();
         while ((inputLine = br.readLine()) != null) {
            responsea.append(inputLine);
         }
         br.close();
         request.setAttribute("data", responsea);
         //System.out.println("responsea.toString()=" + responsea.toString());   
      } catch (Exception e) {
         System.out.println(e);
      }
   %>
${requestScope.data}
<%-- ${requestScope.data.message.result.translatedText}; --%>