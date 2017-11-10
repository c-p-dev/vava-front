<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="/inc/header.jsp" %>


<div id="contents_wrap">
	<div class="game_contents">
		<table width="100%" valign="top" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="260" valign="top">
					<div class="game_left_wrap">
						
						
						
						
							<div ng-include="leftTab">								
							</div>
					
	
						
					</div>
				</td><!-- left -->
				
					<td width="80%" style="padding:0 10px 0 10px;"  valign="top">
							<div ng-include="centerTab"></div>
					</td>

				
				<td width="260" class="game_right_wrap" valign="top">

							<div ng-include="rightTab">								
							</div>
							
				</td>
			</tr>
		</table>
	</div>
</div><!-- contents -->

<%@ include file="/inc/footer.jsp" %>

