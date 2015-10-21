<app_nav>
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-sidebar-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
           <div class="text-center">
               <img src="custom/picture/user.png" alt="" class="profil-picture img-circle">
           </div>

        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-sidebar-navbar-collapse-1">
            <ul class="nav navbar-nav" show={user}>
                <li><a href="#">Accueil<i class="pull-right fa fa-home fa-lg"></i></a></li>
                <li show={user.rank<=1}><a href="#result">Résultat<i class="pull-right fa fa-bar-chart fa-lg"></i></a></li>
                <li show={user.rank==1}><a href="#qcm">Démarrer un QCM<i class="pull-right fa fa-plus fa-lg"></i></span></a></li>
                <li show={user.rank==2}><a href="#themes">Thèmes<i class="pull-right fa fa-cube fa-lg"></i></a></li>
                <li show={user.rank==2}><a href="#modeles">Modèles<i class="pull-right fa fa-cubes fa-lg"></i></a></li>
                <li show={user.rank==0}><a href="#eval">Evaluation<i class="pull-right fa fa-pencil fa-lg"></i></a></li>
                <li><a href="#" onclick={api.logout}>Déconnexion<i class="pull-right fa fa-sign-out fa-lg"></i></a></li>
            </ul>
        </div>
    </div>
    
    <script>
        var self = this;
        
        this.on('mount',function(){
            opts.profile();
        });
        
        //when profile is loaded
        opts.on('profile', function(json) {
            self.user = json.data;
            self.update();
        });
    </script>
</app_nav>
