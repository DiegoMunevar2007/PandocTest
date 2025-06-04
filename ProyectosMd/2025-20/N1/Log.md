# Queso
Toda [[Transacción]] tiene un inicio y un final, el log permite tener el control y registro de la [[Transacción]] para tener en cuenta lo que pudo haber fallado o si la [[Transacción]] se realizó de forma correcta.
> [!Information] 
> Es como tomar la información de una clase en un cuaderno, mi información puede llegar hasta donde yo tomé nota.

Es información redundante pero es necesaria para implementar [[Rollback]].
Debe de tener:
- ID de la [[Transacción]]
- El tipo de la operación
- El ID del registro que está modificando.
Debe tener un apuntador al anterior registro que esta asociado a la [[Transacción]]
#Parcial 
Que significan cada letra
**B**egin: Marca el inicio de la [[Transacción]] (Cuando se pone un B2 o B3, inicia la [[Transacción]] 2, 3, etc)
**U**pdate: Marca alguna inserción, eliminación o update dentro de un recurso.
[[Commit]]: Marca la confirmación de datos
**A**bort ([[Rollback]]): Marca la posibilidad de un [[Rollback]].

### Organización de la memoria
Una vez falla el sistema, el log permite restaurarlo hasta un punto de recuperación. El log debe quedar finalmente en un mecanismo de almacenamiento no volátil.

#### Memoria principal
Es volatil, si se apaga el computador, no se podrá recuperar
#### Memoria secundaria
No es volatil, permite perdurar incluso después de apagar el computador.


