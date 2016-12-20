<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
      #tests {
        font-family:Arial;
      }
      </style>
</head>
<body>

<div id="tests"></div>
    <script>
      var div = document.getElementById("tests"), item, range, textNode, bounds;

      for (var i = 6; i < 72; i++) {
        item = document.createElement("div");
        item.style.fontSize = i + "px";
        item.style.lineHeight = (10 + i * 2) + "px";
        textNode = document.createTextNode(i);
        item.appendChild(textNode);
        div.appendChild(item);

        range = document.createRange();
        range.setStart(textNode, 0);
        range.setEnd(textNode, i.toString().length);
        bounds = range.getBoundingClientRect();

        textNode.nodeValue += " " + bounds.height + " " + bounds.bottom + (i % 3 === 0);

      }

    </script>
    <script src="test.js"></script>


</body>
</html>