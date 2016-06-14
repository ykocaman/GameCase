<h2>Hoşgeldin; <?= $user['name'] ?> <a href="/logout" style="font-size:0.6em">Çıkış</a></h2> 
<table>
	<thead>
		<th width="200">Aktif Hediyelerin</th>
		<th>Adet</th>
	</thead>
	<?php foreach ($gifts_sent as $key => $gift_sent):  ?>
		<tr>
			<td><?= $gift_sent['name'] ?></td>
			<td><?= $gift_sent['count'] ?></td>
		</tr>
	<?php endforeach; ?>
</table>

<div id="message" style="color:red;margin:15px;"></div>

Hediye türü:
<select name="gift">
	<?php foreach ($gifts as $key => $gift): ?>
		<option value="<?= $gift['id'] ?>"><?= $gift['name'] ?></option>
	<?php endforeach; ?>
</select>

<table>
	<thead>
		<th width="200">Arkadaş ismi</th>
		<th></th>
		<th></th>
	</thead>
	<?php foreach ($people as $key => $person): 
			if($person['id'] == $user['id'])
				continue; ?>
		<tr>
			<td><?= $person['name'] ?></td>
			<td><a href="#" onclick="javascript:claim(<?= $person['id'] ?>);return false">İste</a></td>
			<td><a href="#" onclick="javascript:send(<?= $person['id'] ?>);return false">Gönder</a></td>
		</tr>
	<?php endforeach; ?>
</table>

<hr />
<h2>Gelen İstekler</h2>

<table>
	<thead>
		<th width="200">İsteyen ismi</th>
		<th>Hediye</th>
		<th>Durum</th>
		<th colspan="2" align="center">İşlem</th>
	</thead>
	<?php foreach ($gifts_claimed as $key => $gift_claimed): ?>
		<tr>
			<td><?= $gift_claimed['claimer_name'] ?></td>
			<td><?= $gift_claimed['gift_name'] ?></td>
			<td id="status<?= $gift_claimed['id'] ?>"><?= $gift_claimed['status'] ?></td>
			<?php if($gift_claimed['status'] == 'sent' || $gift_claimed['status'] == 'seen'): ?>
				<td id="accept<?= $gift_claimed['id'] ?>"><a href="#" onclick="javascript:accept(<?= $gift_claimed['id'] ?>);return false">Kabul et</a></td>
				<td id="reject<?= $gift_claimed['id'] ?>"><a href="#" onclick="javascript:reject(<?= $gift_claimed['id'] ?>);return false">Reddet</a></td>
			<?php else: ?>
				<td colspan="2"></td>
			<?php endif; ?>
		</tr>
	<?php endforeach; ?>
</table>