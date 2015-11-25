<?php

$entityDef = getModel("entity_definition");
$entityDef->setId($id);

$name = $entityDef->getName();
$code = $entityDef->getCode();
$desc = $entityDef->getDescription();
$attributes = $entityDef->getAttributes();

foreach($attributes as $attribute)
{
	echo $attribute->getValue();
	echo $attribute->getName();
	echo $attribute->getType();
}

 PHP Fatal error:  Allowed memory size of 33554432 bytes exhausted (tried to allocate 92 bytes) in /var/www/vhosts/global-car-trading.ch/global/app/code/core/Mage/Core/Model/Config.php on line 1348

