extends Node

#for general
var floatingText = preload ("res://scene/FloatingText.tscn")
var GrassDestroyed = preload ("res://scene/GrassDestroyed.tscn")
var gunSmoke = preload ("res://scene/Gun and Power/gunExplosion.tscn")


#for player
var bulletPlayer = preload ("res://scene/Gun and Power/BulletPlayer.tscn")
var explosionPlayer = preload ("res://scene/Gun and Power/GunExplosionPlayer.tscn")

#for enemy
var bulletEnemy = preload ("res://scene/Gun and Power/BulletEnemy.tscn")
var explosionEnemy = preload ("res://scene/Gun and Power/GunExplosionEnemy.tscn")
var enemyDeath = preload ("res://scene/Gun and Power/DeathExplosion.tscn")

#debugging
var debug_overlay = preload("res://scene/debug_overlay.tscn")
