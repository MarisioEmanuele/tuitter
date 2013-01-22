
# Un clone di Twitter: associazioni fra le entità

Abbiamo cominciato a sfruttare il supporto di Rails per le associazioni fra le entità, in particolare il metodo "has_many" dei modelli.

Abbiamo sfruttato il fatto che User has_many :tweets, e che Tweet belongs to User.  In questo modo abbiamo semplificato la protezione per il metodo TweetsController#create.

Poi abbiamo incominciato a implementare il modello di "followings" di Twitter.  Un utente può seguirne un'altro.  Questa relazione è simile alla "friendship" di Facebook, con la differenza che è asimmetrica: io posso decidere di seguire chi voglio, ma quelli che io seguo non hanno alcun obbligo di seguire me. Quindi quando l'applicazione crea un following, l'utente corrente è sempre il follower.

La relazione "following" è una relazione molti-a-molti fra utenti e utenti. Per implementarla, la spezziamo in due relazioni uno-a-molti, definendo una entità intermedia che chiamiamo "Following".  Un istanza di Following significa che l'utente X segue l'utente Y.  Quindi per registrare il fatto che X segue Y, dobbiamo salvare nel database un'istanza di Following.  Analogamente, per fare un "Unfollow", bisogna cancellare dal database un'istanza di Following.

Nota: `followed_user_id` è l'utente che viene seguito.  `Follower_user_id` è l'utente che segue.

Abbiamo implementato i bottoni di Follow e Unfollow, ma non funzionano ancora.

## Esercizio

1. Nella home page dell'applicazione, fare in modo che nella scritta "Benvenuto, @tizio", la parola @tizio sia cliccabile.  Deve essere un link che porta alla pagina del profilo di @tizio.

2. Quando sono loggato e visito la pagina del profilo di un altro utente, vedo apparire un bottone "Follow tizio" oppure "Unfollow tizio".  Se provo a cliccare questi bottoni, non funzionano.  L'esercizio consiste nel farli funzionare!
  * Suggerimento: iniziare creando un controller "FollowingsController" con azioni create e destroy
  * Modificare se necessario le route
  * Aggiungere il codice necessario nel controller per creare o distruggere un following
  * Nota che per creare un following devo avere due utenti: il follower è implicitamente l'utente corrente, l'altro viene passato nella URL
  * Ci sono due maniere di creare un Following.  La più semplice è
    `Following.create(:followed_user_id => ..., :follower_user_id => ...)`.  L'altra è agire sulla collezione `current_user.followings_that_i_follow` chiamando il metodo `create!`.  La maniera migliore è sfruttare il metodo `user.start_following(other_user)` che ho implementato nella classe User
    
3. Quando visito la pagina del profilo di un utente, vedo una scritta tipo "Following 12".  Fare in modo che quella scritta sia cliccabile, e porti a una url del tipo "/users/followed_by/678", dove 678 è l'id dell'utente di cui stavamo visitando il profilo.  Quando clicco quel link, deve portarmi ad una pagina che mostra l'elenco degli utenti che sono seguiti dall'utente 678.
  * Suggerimento: iniziare creando il link nel template views/users/show
  * Modificare le route per aggiungere una rotta che porta al metodo "followed_by" di UsersController.  Prendere come esempio la rotta di Users#show.
  * Implementare il metodo followed_by di UsersController.

4. Quando non c'è nessun utente in sessione, la home page mostra l'elenco di tutti i Tweet che ci sono.  Quando invece c'è un utente in sessione, la home page dovrebbe mostrare i tweet di quell'utente, e di tutti gli utenti che segue.  
