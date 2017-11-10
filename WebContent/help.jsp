<%@ include file="/inc/main_header.jsp"%>
<%@ include file="/inc/session.jsp"%>
<%@ include file="/inc/header.jsp"%>
<style>
#tt1 {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
    color:  #191a1b;
}

#tt1 td, #tt1 th {
    border: 1px solid #ddd;
    padding: 8px;
}


#tt1 th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: left;
    background-color:grey;
    color: white;
}
</style>
<div id="wrap">
	<div id="contents_wrap">
			<div class="contents">
				<div class="sub_left">
				<ul class="l_tabs">
					<li><a href="#l-tab1">베팅 가이드</a></li>
					<li><a href="#l-tab2">게임 가이드</a></li>
					<li><a href="#l-tab3">자주 묻는 질문</a></li>
					<li><a href="#l-tab4">이용약관</a></li>
				</ul>
			</div>	
				<div class="sub_right">
					<div id="l-tab1" class="left_tab_con">
						<li>
							<div class="acc_head"><h3>스포츠 베팅 타입의 이해</h3></div>
							<div class="acc_content">
								<div class="acc_content_in_2">
									<p style="font-weight: bold;">■ 승무패 1×2</p>
									<br>
									<p>1은 홈팀승 , X는 무승부, 2는 어웨이팀승으로 한다.승무패에 관한 경기 결과를 예측하여 베팅 , 적중시 해당 배당률로 당첨금 지급</p>
									<br><br>
									<p style="font-weight: bold;">■ 오버언더 – U/N (OVER/UNER)</p>
									<br>
									<p>A팀 vs B팀 경기 , 오버언더 기준점 2.5  (골, 코너킥, 옐로우 카드등 다양함)</p>
									<p> 경기 종료시 양팀합산 3 이상시 오버 ▲</p>
									<p>경기 종료시 양팀합산  2 이하시 언더 ▼</p>
									<br><br>
									<p style="font-weight: bold;">■ 더블찬스 – DOUBLE CHANCE</p>
									<br>
									<p>A팀 vs B팀 경기</p>
									<table style=" width: 50%;" >
										<tr>
											<td>A , X</td>
											<td>1.5</td>
											<td>B , X</td>
											<td>1.4</td>
											<td>A , B</td>
											<td>1.2</td>
										</tr>
									</table>
									<br>
									<p>위와같은 경기가 있을 경우 아래와 같은 배팅을 할수 있습니다</p>
									<p><font style="font-weight:bold">A , X</font> 베팅시 = A팀이 승리하거나 무승부일시 당첨</p>
									<p><font style="font-weight:bold">B , X</font> 베팅시= B팀이 승리하거나 무승부일시 당첨</p>
									<p><font style="font-weight:bold">A , B</font> 경기가 중립 장소에서 진행되는 경우 왼편에 나열된 팀을 홈 팀으로 간주합니다.</p>
									<p>경기가 중립 장소에서 진행되는 경우 왼편에 나열된 팀을 홈 팀으로 간주합니다.</p>
									<br><br>
									<p style="font-weight: bold;">■ 아시안 핸디캡 – ASIAN HANICAP</p>
									<br>
									<p>아시안 핸디캡은 일정팀에 사전에 정한 점수를 미리 지급함 으로써 승패에 베팅을 하는 게임입니다</p>
									<p>게임의 룰은 아래와 같습니다</p>
									<p>+0.25의 점수를 가지고 시작하는 팀에 베팅을 하였을 </p>
									<p>경우 경기 결과가1:0 승리시 당첨 0:0 무승부시 절반 승리로 배팅금+당첨금의 50% 을 수령합니다.</p>
									<p>-0.25의 점수를 가지고 시작하는 팀에 베팅을 하였을 </p>
									<p>경우 경기 결과가 1:0 승리시 당첨, 0:0 무승부시 절반 패배로 배팅금의 절반을 수령합니다.</p>
									<p>+0.75의 점수를 가지고 시작하는 팀에 배팅을 하였을 </p>
									<p>경우 경기 결과가 0:1 패배시 절반 패배로 배팅금의 50% 수령합니다.</p>
									<p>-0.75의 점수를 가지고 시작하는 팀에 배팅을 하였을</p>
									<p>경우 경기 결과가 1:0 승리시 절반 승리로 배팅금+당첨금의 50%을 수령합니다.</p>
									<p>자세한 기준점에 대한 베팅 예시 사항은 아래의 표를 참고 하시기 바랍니다.</p>
									<br><br>
									<table id="tt1">
									    <tr>
									        <th style="text-align: center">핸디캡 기준점</th>
									        <th style="text-align: center">팀 결과</th>
									        <th style="text-align: center">베팅 결과</th>
									    </tr>
									    <tr>
									        <td rowspan="3">0</td>
									        <td style="text-align: center">승리</td>
									        <td style="text-align: center">승리</td>
									    </tr>
									    <tr>
									        <td>무승부</td>
									        <td style="text-align: center">1배처리</td>
									    </tr>
									    <tr>
									        <td>패</td>
									        <td style="text-align: center">패</td>
									    </tr>
									    <tr>
									        <td rowspan="3">– 0.25(0--0.5)</td>
									        <td style="text-align: center">승리</td>
									        <td style="text-align: center">승리</td>
									    </tr>
									    <tr>
									        <td>무승부</td>
									        <td style="text-align: center">절반 패배 (배팅금의 50%)</td>
									    </tr>
									    <tr>
									        <td>패</td>
									        <td style="text-align: center">패</td>
									    </tr>
									    <tr>
									        <td rowspan="3">– 0.50(-0.25--0.75)</td>
									        <td style="text-align: center" >승리</td>
									        <td style="text-align: center">승리</td>
									    </tr>
									    <tr>
									        <td>무승부</td>
									        <td style="text-align: center">패</td>
									    </tr>
									    <tr>
									        <td>패</td>
									        <td style="text-align: center">패</td>
									    </tr>
									</table>
									<br>
									<table id="tt1">
									    <tr>
									        <th style="text-align: center">핸디캡</th>
									        <th style="text-align: center">팀 결과</th>
									        <th style="text-align: center">베팅 결과</th>
									    </tr>
									    <tr>
									        <td rowspan="3">0</td>
									        <td style="text-align: center">승리</td>
									        <td style="text-align: center">승리</td>
									    </tr>
									    <tr>
									        <td>무승부</td>
									        <td style="text-align: center">1배처리</td>
									    </tr>
									    <tr>
									        <td>패</td>
									        <td style="text-align: center">패</td>
									    </tr>
									    <tr>
									        <td rowspan="3">– 0.25(0--0.5)</td>
									        <td style="text-align: center">승리</td>
									        <td style="text-align: center">승리</td>
									    </tr>
									    <tr>
									        <td>무승부</td>
									        <td style="text-align: center">절반의 승리 (배팅+당첨금의 50%)</td>
									    </tr>
									    <tr>
									        <td>패</td>
									        <td style="text-align: center">패</td>
									    </tr>
									    <tr>
									        <td rowspan="3">– 0.50(-0.25--0.75)</td>
									        <td style="text-align: center">승리</td>
									        <td style="text-align: center">승리</td>
									    </tr>
									    <tr>
									        <td>무승부</td>
									        <td style="text-align: center">승리</td>
									    </tr>
									    <tr>
									        <td>패</td>
									        <td style="text-align: center">패</td>
									    </tr>
									</table>
									<br>
									<table id="tt1">
									    <tr>
									        <th rowspan="4" style="background-color: grey;">-1.00</td>
									        <th style="text-align: center">2점차에 의해 승리</th>
									        <th>승리</th>
									    </tr>
									    <tr>
									        <td>1점차에 의해 승리</td>
									        <td style="text-align: center">1배처리</td>
									    </tr>
									    <tr>
									        <td>무승부</td>
									        <td style="text-align: center">패</td>
									    </tr>
									    <tr>
									        <td>패</td>
									        <td style="text-align: center">패</td>
									    </tr>
									    <tr>
									         <th rowspan="4" style="background-color: #191a1b;">-1.25</td>
									        <td style="text-align: center">2점차에 의해 승리</td>
									        <td style="text-align: center">승리</td>
									    </tr>
									    <tr>
									        <td>1점차에 의해 승리</td>
									        <td style="text-align: center">절반 패배 (배팅금의 50%)</td>
									    </tr>
									    <tr>
									        <td>무승부</td>
									        <td style="text-align: center">패</td>
									    </tr>
									    <tr>
									        <td>패</td>
									        <td style="text-align: center">패</td>
									    </tr>
									    <tr>
									         <th rowspan="4" style="background-color: #191a1b;">– 1.50</td>
									        <td style="text-align: center">2점차에 의해 승리</td>
									        <td style="text-align: center">승리</td>
									    </tr>
									    <tr>
									        <td>1점차에 의해 승리</td>
									        <td style="text-align: center">패</td>
									    </tr>
									    <tr>
									        <td>무승부</td>
									        <td style="text-align: center">패</td>
									    </tr>
									    <tr>
									        <td>패</td>
									        <td style="text-align: center">패</td>
									    </tr>
									</table>
								</div>
							</div>
						</li>
					</div>
					<div id="l-tab2" class="left_tab_con">
						<ul class="smk_accordion">
							<li>
								<div class="acc_head"><h3>Baccarat (바카라)</h3></div>
								<div class="acc_content">
									<div class="acc_content_in_2">
										<p>가장 드라마틱한 테이블 게임</p>
										<p style="font-weight: bold;">고객은 플레이어(Player)와 뱅커(Banker) 중 어느 핸드가 이길지 예상하여 베팅을 합니다. </p>
										<p style="font-weight: bold;">비길 것을 예상하여 타이(Tie)에 함께 베팅하기도 합니다.</p>
										<br><br>
										<p>베팅은 카지노가 정한 리미트(Limit, 베팅 가능 최저 금액과 최고 금액, 게임 옵션 참고) 범위 내에서 하시면 됩니다.</p>
										<p>딜러가 드로잉 룰에 따라 플레이어와 뱅커에 카드를 드로잉하여 플레이어, 뱅커 중 9에 가까운 쪽이 이깁니다.</p>
										<p>플레이어, 뱅커의 각 2장 혹은 3장의 합으로 게임 승패가 결정됩니다.</p>
										<p>TIP 많은 분들이 플레이어는 고객, 뱅커는 카지노의 영역으로 오해하는데, 고객이 플레이어와 뱅커 중 이기는 쪽을</p>
										<p>예상하여 베팅을 하는 게임입니다. 고객은 플레이어와 뱅커 어느 쪽이든 베팅 할 수 있습니다.</p>
										<br><br>
										<p>이긴 쪽에 베팅된 금액은 고객에게 지급하고, 진 쪽에 베팅된 금액은 수거합니다.</p>
										<p>플레이어가 이길 경우 베팅한 금액만큼(100%) 페이하고, 뱅커가 이길 경우 5%의 커미션을 공제(95%)하고 지급합니다.</p>
										<br><br>
										<p>비길 경우 Tie에 베팅한 고객에게 베팅액의 8배를 드리며, 이때 원금은 수거하지 않습니다.</p>
										<br><br>
										<p style="font-weight: bold;">카드의 가치</p>
										<p>10과 그림카드(KING, QUEEN, JACK)는 모두 0으로 계산됩니다. 그 외의 카드는 표시된 숫자로 계산됩니다. A 는 1입니다.</p>
										<br><br>
										<p style="font-weight: bold;">카드의 순위</p>
										<p style="font-weight: bold;">NATURAL</p>
										<p>가장 높은 순위는 내추럴(Natural)입니다. 플레이어나 뱅커 사이드 중 어느 쪽이든 두 장의 합이 9, 8이면 게임은 종료됩니다.(4장으로 게임 종료)</p>
										<p style="font-weight: bold;">STAND</p>
										<p>플레이어 두 장의 합이 7, 6일 때, 뱅커 두 장의 합이 7일 때 스탠드(Stand)인데, 어느 쪽이든 스탠드일 경우 더 이상 카드를 받지 않고 스탠드합니다.</p>
										<p>양쪽이 전부 스탠드일 때 추가 카드 드로잉이 없이 게임이 종료됩니다.(4장 혹은 5장으로 게임 종료)</p>
										<p style="font-weight: bold;">NOTHING</p>
										<p>플레이어, 뱅커 모두 스탠드보다 낮을 경우 플레이어가 먼저 한 장을 받는데, 이때 나온 플레이어 카드의 가치에 따라 게임이 종료되기도 하고, 뱅커 카드를 한 장 더 받고 종료되기도 합니다.</p>
										<p>(5장 혹은 6장으로 종료)</p>
										<br><br>
										<p style="font-weight: bold;">페어 벳(Pair bet)</p>
										<p>플레이어 혹은 뱅커 사이드에 처음 드로잉 된 2장의 카드(Initial two cards)가 같은 가치를 지닌 경우 (One Pair), 페어벳 베팅을 한 고객에게 11배를 지급합니다.</p>
										<p>페어벳 베팅을 했는데 페어가 없는 경우에는 페어벳 베팅금을 수거하며, 페어벳은 플레이어 페어벳, 뱅커 페어벳으로 각각 나뉘어져 있어 원하시는 쪽에 베팅하실 수 있습니다.</p>
										<p>게임에 참가 중인 다른 고객이 베팅하지 않은 금액만큼 추가 베팅이 가능합니다.</p>
										<p>10 – J, J – K, Q – K 등과 같이 바카라에서의 가치는 0으로 같지만 Pair가 아니기 때문에 인정되지 않습니다.</p>
										<p>오리지날 베팅 없이 타이나 페어벳 만으로 게임 참여가 가능합니다. 이 때, 카드는 오픈으로 뽑습니다.</p>
									</div>
								</div>
							</li>
							<li>
								<div class="acc_head"><h3>BlackJack (블랙잭)</h3></div>
								<div class="acc_content">
									<div class="acc_content_in_2">
										<p>가장 인기가 많은 카지노 게임</p>
										<p>게임 개요</p>
										<p>블랙잭은 고객들이 가장 선호하는 카지노 게임의 하나로, </p>
										<p>21 또는 21에 가까운 숫자를 만들어 딜러 보다 높으면 이기는 게임입니다.</p>
										<p>고객에게 드로잉 된 최초 카드 2장(Initial two cards)의 높낮이에 따라 추가 카드를 받거나(Hit) </p>
										<p>멈출 수 있으며 (Stay), 딜러보다 불리하다고 판단되면 베팅 금액의 절반을 포기하는 </p>
										<p>조건으로 게임을 종료할 수 있습니다.</p>
										<p>(이때 Hit, Stay, Surrender는 반드시 정해진 핸드 시그널로 표시해야 합니다.)</p>
										<p>딜러는 이니셜 투 카드가 16 이하일 때, 17이상이 될 때까지 카드를 받아야 하며, 딜러와 </p>
										<p>플레이어 모두 21을 초과하면 지게</p>
										<p>됩니다. 이를 버스트(Bust)라고 합니다.</p>
										<p>플레이어가 버스트하게 되면 해당 게임은 종료되며, 딜러가 버스트하게 되는 경우에는 </p>
										<p>버스트하지 않은 플레이어가 이기게 됩니다. 플레이어들의 카드와 비교하여, 딜러보다 높은</p>
										<p>카드의 베팅금액은 지급하고, 딜러보다 낮은 카드의 베팅 금액은 수거하며, 딜러와 </p>
										<p>플레이어의 카드가 같을 경우 비기게 되어 지급, 수거 없이 게임을 종료시킵니다.</p>
										<p>이니셜 투 카드 (처음 2장의 카드)의 조합이『A + any 10(10,J,Q,K)』으로, 합이 '21' 인 </p>
										<p>경우가 가장 높은 카드이며, 이를 블랙잭이라 합니다. 플레이어가 블랙잭일 경우 1.5배를</p>
										<p>지급하며, 딜러와 플레이어 모두 블랙잭일 경우 비기게 되며, 딜러가 블랙잭일 경우에는 </p>
										<p>딜러가 이기게 됩니다.</p>
										<br><br>
										<p style="font-weight: bold;">카드의 가치</p>
										<p>“ACE”는 1 또는 11로 계산됩니다. </p>
										<p>그림카드 (KING, QUEEN, JACK)는 모두 10으로 계산되며, 그 외의 카드는 표시된 숫자로 계산됩니다</p>
										<br>
										<p>이니셜 투카드로 Ace와 10 카드를 받을 경우 이를 블랙잭이라 하며, 이니셜 투카드에 Ace가 있어 11로 카운팅이 가능한 경우 소프트 핸드라고 합니다.</p>
										<br>
										<p>카드를 더 받고자 할 때, Hit버튼을 클릭하시면 됩니다.</p>
										<p>추가로 카드를 받지 않고자 할 때, Stay버튼을 클릭하시면 됩니다.</p>
									</div>
								</div>
							</li>
							<li>
								<div class="acc_head"><h3>Roulette (룰렛)목</h3></div>
								<div class="acc_content">
									<div class="acc_content_in_2">
										<p>누구나 쉽게 할 수 있는 카지노 게임</p>
										<p>게임 개요</p>
										<p style="font-weight: bolder;">룰렛은 특별한 규칙이 없다고 할 수 있는 게임으로 초보자라도 쉽게 즐길 수 있기 때문에 가장 대중적인카지노 게임 중 하나입니다. </p>
										<p style="font-weight: bolder;">딜러가 회전시킨 볼이 회전하고 있는 휠(회전판) 상의 어떤 번호(번호/색깔 등)에 낙착할 것인가를 알아맞추는 게임입니다.</p>
										<p>휠 상의 번호들은 테이블 레이아웃에 표시가 되어 있으며, 이곳에 원하는 곳에 베팅하면 됩니다.</p>
										<p>맞춘 칩스에 대해서는 각각의 배당률에 따라 배당을 받게 되며, 맞추지 못한 칩스는 수거되어 잃게 됩니다.</p>
										<br>
										<p style="font-weight: bold;">룰렛 베팅의 종류</p>
										<p style="padding-left: 10px; font-weight: bold; text-decoration: underline"> 컬럼 벳/투엘브넘버 벳 (Column Bet / Twelve Number Bet)칩스를 레이아웃 하단에 위치한  </p>
										<p style="padding-left: 10px; font-weight: bold; text-decoration: underline">세 개의 공간 중에 선택하여 놓습니다.</p>
										<p style="padding-left: 10px; font-weight: bold; text-decoration: underline">이 베팅은 해당 공간의 상위 수직선상의 12개 번호를 가리킵니다. (1:2)</p>
										<br><br>
										<p style="padding-left: 10px; font-weight: bold; text-decoration: underline">다즌벳 (Dozen Bet)칩스를 레이아웃의 『1st 12』, 『2st 12』, 『3st 12』라고 표시된 지점에 놓습니다.</p>
										<p style="padding-left: 10px; font-weight: bold; text-decoration: underline">『1st 12』는 1부터 12까지의 숫자를 가르키며, 『2st 12』는 13부터 24, 『3st 12』는 25부터 36까지의 숫자를 가르킵니다. (1:2)</p>
										<br><br>
										<p style="padding-left: 10px; font-weight: bold; text-decoration: underline">다즌벳 (Dozen Bet)칩스를 레이아웃의 『1st 12』, 『2st 12』, 『3st 12』라고 표시된 지점에 놓습니다.</p>
										<p style="padding-left: 10px; font-weight: bold; text-decoration: underline">이븐/아드 넘버 벳 (Even/Odd Number Bet)0과 00를 제외한 레이아웃 상의 모든 번호는 짝수 (Even)와 홀수 (Odd)로 구분됩니다. (1:1)</p>
										<br><br>
										<p style="padding-left: 10px; font-weight: bold; text-decoration: underline">칼라 벳 (Color Bet)0과 00를 제외한 레이아웃 상의 모든 번호는 적색 (Red)와 흑색 (Black)으로 구분됩니다. (1:1)</p>
										<br><br>
										<p style="padding-left: 10px; font-weight: bold; text-decoration: underline">스트레이트 벳 (Straight Bet) 싱글 넘버 벳 (Single Number Bet)한 번호를 겨냥하여 베팅합니다. (1:35)</p>
										<br><br>
										<p style="padding-left: 10px; font-weight: bold; text-decoration: underline">스플릿 벳 (Split Bet) 투넘버 벳 (Two Number Bet)두 번호를 겨냥하여 칩스를 두 번호 사이의 선 위에 베팅합니다. (1:17)</p>
										<br><br>
										<p style="padding-left: 10px; font-weight: bold; text-decoration: underline">스트릿 벳 (Street Bet) 쓰리 넘버 벳 (Three Number Bet)세 번호를 겨냥하여 칩스를 레이아웃을 가로지르는 3가지 번호가 있는 선 위에 베팅합니다. (1:11)</p>
										<br><br>
										<p style="padding-left: 10px; font-weight: bold; text-decoration: underline">스퀘어 벳 (Square Bet) 코너벳 (Corner Bet) 포넘버 벳(Four Number Bet)네 번호를 겨냥하여 네 가지 번호가 교차하는 중간선 위에 베팅합니다. (1:8)</p>
										<br><br>
										<p style="padding-left: 10px; font-weight: bold; text-decoration: underline">파이브넘버 벳 (Five Number Bet)칩스를 1,2,3,0,00을 분리시키는 모서리 지점에 베팅합니다. (1:6)</p>
										<br><br>
										<p style="padding-left: 10px; font-weight: bold; text-decoration: underline">라인 벳 (Line Bet) 식스 넘버 벳 (Six Number Bet)칩스를 두 개의 Street 벳이 교차하는 선 위에 놓습니다. (1:5)</p>
									</div>
								</div>
							</li>
						</ul>
					</div>
					<div id="l-tab3" class="left_tab_con">
						<ul class="smk_accordion">
							<li>
								<div class="acc_head"><h3>회원 가입 관련</h3></div>
								<div class="acc_content">
									<div class="acc_content_in_2">
										<p style="font-weight:bold">Q 아이벳 회원 가입은 어떻게 하나요?</p>
										<br>
										<p>사이트 우측 상단에 “회원가입” 클릭후 필요한 정보를 작성 후 가입하시면 됩니다.
										회원 가입은 해당 국가의 법적나이 19세 이상만 가능하며 유효한 휴대폰 번호를 입력하셔야 합니다.</p>
										<br><br>
										<p style="font-weight:bold">Q 사이트에 가입하면 어떤 의무사항이 있나요?</p>
										<br>
										<p>가입 후 30일 이내 사이트 이용내역이 없는경우, 자동으로 회원 탈퇴가 이루어지게 됩니다.</p>
										<p style="color:#ffa800;"> 가입하는 것은 사이트의 이용에 대한 약관에 동의 하는 것입니다.</p>
										<br><br>
										<p style="font-weight:bold">Q 어떤 경우에 계정이 정지 되나요?</p>
										<br>
										<p> 약관에 어긋나는 베팅을 하였을 경우,불법적인 방법으로 입금한 경우
											채팅, 전화 그리고 이메일로 서포트 연락 시 부적절 한 언어를 사용한 경우
											통보없이 계정이 정지될 수 있습니다. </p>
										<br><br>
										<p style="font-weight:bold">Q 중복가입은 가능한가요?</p>
										<br>
										<p><font style="color:#ffa800;">가입은 1인1계정 입니다. 만약 중복 계정이 발견되면 통보 없이 계정삭제</font>가 됩니다</p>
										<br><br>
										<p style="font-weight:bold">Q 본인 개인정보 변경은 어떻게 하나요?</p>
										<br>
										<p>상단 ‘내 정보’ 클릭 후  변경 가능하며, 휴대폰번호 혹은 계좌번호 변경 시
										고객센터로 통보해주셔야만 계좌변경 및 이벤트에 대한 소식을 받아보실 수 있습니다.</p>
										<br><br>
										<p style="font-weight:bold">Q 비밀번호를 잊어 버렸을 때 어떻게 해야 하나요?</p>
										<br>
										<p> 비밀번호를 잃어버렸을 경우 사이트내 휴대폰 번호 인증 후 변경가능합니다 . 이외에 방법은 없습니다.</p>
										<br><br>
										<p style="font-weight:bold">Q 로그인이 안되요?</p>
										<br>
										<p>로그인이 안될 때는 익스플로러 또는 크롬 쿠키 삭제 및 방문내역을 삭제 후 로그인하시면 됩니다.</p>
									</div>
								</div>
							</li>
							<li>
								<div class="acc_head"><h3>베팅 관련</h3></div>
								<div class="acc_content">
									<div class="acc_content_in_2">
										<p style="font-weight:bold">Q 스포츠 베팅 시 최대 베팅 한도 및 최대 베팅 가능한 폴더 수는 어떻게 되나요?</p>
										<br>
										<p><font style="color:#ffa800;">해외 배팅업체의 경우 각 리그 , 해당팀, 배당률에 따라 최대 베팅한도는 상이</font>합니다.</p>
										<p>이는 최대 베팅 가능한 폴더 수 및 베팅 상한가 도 똑같이 적용됩니다.</p>
										<p>그로 인해 베팅 한도 및 베팅 상한가는 게임마다 다르게 적용되고 있습니다. </p>
										<p><font style="color:#ffa800;">베팅하시려는 경기의 본인 최대 베팅 한도를 알고 싶으시면</font></p>
										<p><font style="color:#ffa800;">로그인 후 베팅하실 경기 배당에 마우스를 올리거나 각 경기 선택 후 배팅슬립 하단 ‘맥스’ </font></p>
										<p><font style="color:#ffa800;">버튼을 누르시면 확인 가능</font>합니다.</p>
										<p>로그인 전 에는 ‘맥스’ 버튼이 활성화 되지 않습니다.</p>
										<br><br>
										<p style="font-weight:bold">Q 베팅 슬립에 나오는 베팅종류는 무엇인가요?</p>
										<br>
										<p>아이벳 에서는 단폴 베팅, 조합 베팅 이렇게 2종류의 베팅 종류를 제공합니다. </p>
										<br><br>
										<p style="font-weight:bold; color:#00afed;">1-단폴 베팅</p>
										<br>
										<p>베팅 슬립에 담긴 경기들을 개별적으로 베팅 금액을 설정할 수 있으며,</p>
										<p>베팅 금액이 설정된 경기들은 한 번의 클릭으로 모두 단 폴더 베팅할 수 있습니다.</p>
										<br><br>
										<p style="font-weight:bold; color:#00afed;">2-조합베팅</p>
										<br>
										<p>베팅 슬립에 담긴 여러 개의 경기들을 조합 하여 베팅할 수 있습니다</p>
										<p>다만 베팅 카트에 담긴 내역 중 조합 베팅이 가능하지 않는 내역은</p>
										<p>카트에 경고 표시되며 대상 경기 중 하나를 삭제 하시면 정상적으로</p>
										<p>베팅 처리가 완료 됩니다.</p>
										<br><br>
										<p style="font-weight:bold">Q 라이브 베팅 시 베팅 완료가 되지 않거나 간섭이 일어나는 이유는 무엇인가요?</p>
										<br>
										<p>아래의 이유들로 인해서 이와 같은 상황이 발생될 수 있습니다.</p>
											<p>- 인터넷 서비스 회사의 문제</p>
											<p>- 갑자기 너무 많은 베팅이 몰렸을 때</p>
											<p>- 해당 경기가 너무 빠르게 진행되고 있고 배당 조정이 급격히 일어날때</p>
											<p>- 기술적인 문제(소프트웨어 문제, 정전 등)</p>
											<p>- 자연재해</p>
										<br><br>
										<p style="font-weight:bold">Q 베팅한 경기의 배당률이 시간이 지나도 멈춰 있는 경우</p>
										<br>
										<p>배당률이 시간이 지나도 멈추어 있는 경우는 해당 경기의 생방송이 멈추거나, 소프트웨어 문제</p>
										<p>그리고 정전 등의 이유로 일어날 수 있습니다.</p>
										<br><br>
										<p style="font-weight:bold">Q 베팅한 경기의 배당률이 시간이 지나도 멈춰 있는 경우</p>
										<br>
										<p>배당률이 시간이 지나도 멈추어 있는 경우는 해당 경기의 생방송이 멈추거나, 소프트웨어 문제</p>
										<p>그리고 정전 등의 이유로 일어날 수 있습니다.</p>
										<br><br>
										<p style="font-weight:bold">Q 라이브 베팅에 있는 경기 시간과 스코어 등이 정확하지 않은 경우</p>
										<br>
										<p>의도되지 않은 기술적 이유로 드물게 일어나는 경우가 있습니다. 라이브 베팅에서 제공하는
										경기시간은 지표일 뿐입니다. 실제 확인 가능한 경기만 베팅에 이용하시기 바랍니다.
										당사는 위에 보여지는 정보 즉,<font style="color:#ffa800;"> 스코어 혹은 경기시간의 정확성 및  현재성에 대하여 책임이
										없음을 알려 드립니다.
										만약 베팅시점에 보여지는 정보가 부정확 했더라도 실제 경기의 결과와
										배당이 적용됨을  알려드립니다.</font></p>
										<br><br>
										<p style="font-weight:bold">Q 나의 베팅한도가 줄어 들었을때</p>
										<br>
										<p>어느 북메이커든지 플레이어의 베팅한도를 줄일 수 있는 권리를 가지고 있으며 이 사항에
										대하여 설명할 의무가 없습니다.</p>
										<p>그리고 북메이커는 합당한 이유가 있을 시 플레이어의 계정을 정지 시킬 수 있습니다.</p>
										<br><br>
										<p style="font-weight:bold">Q 라이브 페이지에서 경기도중 베팅한 경기가 사라졌습니다. 베팅은 어떻게 처리되나요?</p>
										<br>
										<p>해당 경기의 공식정보가 업데이트 되지 않아 중단된 경우입니다. 라이브 도중 경기가
										사라져도 완료된 베팅은 공식결과가 나오는대로 정상 처리됩니다. 해당 경기의 공식정보가 없을</p>
										<p>사라져도 완료된 베팅은 공식결과가 나오는대로 정상 처리됩니다. 해당 경기의 공식정보가 없을</p>
										<br><br>
										<p style="font-weight:bold">Q 축구 경기 중 만약 한 선수가 2장의 옐로우 카드를 받을 시 베팅 결과 처리</p>
										<br>
										<p>두 번째 옐로우 카드를 받으면 레드카드를 받는 것과 같이 선수는 퇴장을 당하므로 두 번째
										옐로우 카드는 레드카드로 간주합니다. 그러므로 옐로우 카드 1장과 레드카드 1장을 받은
										것으로 베팅결과에 적용됩니다</p>
										<br><br>
										<p style="font-weight:bold">Q 테니스 경기 중 만약 한 선수가 기권할 시 베팅 결과 처리</p>
										<br>
										<p>만약 한 선수가 부상 등의 이유로 기권할 시 베팅은 적특 처리됩니다.</p>
										<br><br>	
										<p style="font-weight:bold">Q 테니스 경기 중 만약 한 선수가 기권할 시 베팅 결과 처리</p>
										<br>
										<p>경기 시작 시간이 표기와 다르게 몇 시간 빠르거나 늦게 시작되어도 실제 경기 시작전에 베팅이 </p>
										<p>완료되면 정상 처리됨을 알려 드립니다.</p>
										<p><font style="color: #ffa800;">그리고 베팅 이후의 취소는 불가합니다.</font></p>									
										<br><br>
										<p style="font-weight:bold">Q 베팅 취소는 가능한가요?</p>
										<br>
										<p><font style="color: #ffa800;">베팅 취소는 ‘하루3회’ 가능 </font>합니다. 진행중인 경기가 포함되어 있는 다폴더 베팅은 취소가 불가능하며, 베팅후 10분 이내에만 취소가 가능합니다.</p>									
										<br><br>									
									</div>
								</div>
							</li>
							<li>
								<div class="acc_head"><h3>입금,출금 관련</h3></div>
								<div class="acc_content">
									<div class="acc_content_in_2">
										<p style="color:maroon;">※ 아이벳 "원화 계좌이체 " 방식의 입출금은 "아이벳" 의 엄격한 자금 보호 아래 진행하며  마스터, 에이젼시의 원화 입출금은 불허합니다.</p>
										<br><br>
										<p style="font-weight:bold">Q 입금계좌 확인은 어떻게 하나요?</p>
										<br>
										<p>계좌확인은 입금 신청시 비밀번호를 입력하면 자동 안내됩니다.</p>
										<p style="color:#ffa800;">계좌는 수시로 변경되기 때문에 입금 전에는 반드시 안내되는 계좌로 입금하셔야 합니다.</p>
										<br><br>
										<p style="font-weight:bold">Q 수표로 입금 가능한가요?</p>
										<br>
										<p style="color:#ffa800;">수표입금은 절대 불가합니다. 만약 수표입금 시 통보 없이 계정삭제가 될 수 있습니다.</p>
										<br><br>
										<p style="font-weight:bold">Q 실수로 구계좌로 입금했어요?</p>
										<br>
										<p>구 계좌로 입금 시에는 저희 쪽에서 확인이 불가능 합니다. 그로 인해 충전도 불가능합니다.</p>
										<br><br>
										<p style="font-weight:bold">Q 입금 출금은 어떻게 하나요?</p>
										<br>
										<p style="color:#ffa800;">입금 시에는 개인정보란에 등록된 본인 이름과 입금자명이 동일해야 합니다. 타인명의로 입금 시 충전이 불가하며 강퇴처리될 수도 있습니다.</p>
										<p style="color:#ffa800;">출금은 슈퍼마스터에 등록된 본인 명의의 계좌로만 출금이 됩니다. 하루 최대 3회 출금이 가능합니다.</p>
										<br><br>
										<p style="font-weight:bold">Q 입금 시 입금하지 않고 “충전확인”을 클릭하면 어떻게 되나요?</p>
										<br>
										<p style="color:#ffa800;">아이벳 사용약관에 의하여, 허위로 “충전확인”를 클릭하시면 계정이 즉시 정지 되오니,반드시 입금을 완료하시고 “충전확인”를 클릭해주세요.</p>
										<br><br>
										<p style="font-weight:bold">Q 입금 후 베팅을 하지 않고 바로 출금이 가능한가요?</p>
										<br>
										<p>불가능 합니다. 불법자금 세탁방지 및 입금 시 수수료등이 발생하기 때문에 입금 후 전액 베팅을 하지 않으시면 출금이 되지 않습니다.</p>
										<br><br>
										<p style="font-weight:bold">Q 입금 출금은 얼마까지 가능한가요?</p>
										<br>
										<p>입금 출금액에 대한 한도는 없습니다.<font style="color:#ffa800;">다만 계좌 이체 방식의 일일 출금의 경우 평소 회원과 당사와의 입출금 거래 금액을 기준으로</font></p>
										<p><font style="color:#ffa800;">이에 크게 벗어나는 출금 금액일 경우 그 금액을 나누어 송금 시킬 수 있습니다. </font>이는 한국 자본거래법 (은행 모니터링 후 금감원 자동통보)</p>
										<p>기준에 따른 사항이며 <font style="text-decoration: underline;">이런 사항이 발생할경우 당사 자금팀은 지체없이 회원에게 보고해야할 의무가 있습니다.</font></p>
										<p><font style="text-decoration: underline;">※다른 기타 결제수단을 원할 경우 ( 비트코인 및 유로 , 달러화 결제 ) 고객센터를 통해 문의바랍니다.</font></p>
										<br><br>
										<p style="font-weight:bold">Q 출금이 왜 안되나요?</p>
										<br>
										<p>충전 후 돈이 들어오지 않은 경우는 새로 고침 하시면 회원님의 보유머니가 정상적으로 보입니다.</p>
										<br><br>
										<p style="font-weight:bold">Q 계좌 번호를 변경 하고 싶은데 가능 한가요?</p>
										<br>
										<p>귀하의 잔액이 0 일 때 메시지로 문의 하시면 변경 가능 합니다.</p>
										<p>잔액이 남아있는 경우 기존 등록된 계좌로 잔액을 모두 송금합니다.</p>
										<p>단, 거래 내역이 없는 계좌는 변경이 불가능 합니다.</p>
									</div>
								</div>
							</li>
						</ul>
					</div>
					<div id="l-tab4" class="left_tab_con">
						TOF
					</div>
				</div>
			</div>
		</div>
	</div><!-- main_contents -->
</div><!-- wrap -->
<%@ include file="/inc/footer.jsp"%>