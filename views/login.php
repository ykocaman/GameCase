<h2>Devam etmek için giriş yapınız<h2>
<form method="POST">
	<select name="user">
	<?php foreach ($users as $key => $user): ?>
		<option value="<?= $user['id'] ?>"><?= $user['name'] ?></option>
	<?php endforeach; ?>
	</select>
	<input type="submit" value="Giriş" />
</form>