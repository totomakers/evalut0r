<questions_add> 
    <div class="animated fadeIn">
        <div class="row">
            <div class="col-lg-12 animated fadeIn" id="theme_title" hidden>
                <h1> <a data-toggle="tooltip" data-placement="bottom" title="Retour" href="javascript:history.back()"><i class="fa fa-chevron-left"></i></a> Theme {theme.name} <small> - {theme.description} </small></h1>
                <hr>
            </div>
        </div>
        <div class="row animated fadeIn" show={alert.display} >
            <div class="col-lg-8">
                <div id="alert_block" class="alert alert-danger">
                    {alert.message}
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-4">
                <h2><small>Nouvelle question :</small></h2>
            </div>
        </div>
        <form id="questions_form">
            <div class="row">
                <div class="col-lg-8">
                    <div class="form-group">
                        <label for="question"></label>
                        <textarea class="form-control textarea-fixed" id="question" name="question" rows="10"></textarea>
                    </div>
                    <div class="table-responsive">
                        <table id="question_data" class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Réponse</th>
                                    <th>Bonne réponse</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><input type="text" class="form-control" id="answer_add_wording" oninput={answer_input} placeholder="Libellé"></input></td>
                                    <td>
                                        <span class="checkbox checkbox-success">
                                            <input type="checkbox" class="styled" id="answer_add_good">
                                            <label for="answer_add_good"></label>
                                        </span>
                                    </td>
                                    <td class="text-right"><button id="answer_add_submit" class="btn btn-success btn-lg" onclick={answer_add}><i id="answer_submit_ico" class="fa fa-plus fa-lg"></i></button></td>
                                </tr>
                                <tr each={answers}>
                                    <td>{wording}</td>
                                    <td>
                                        <span class="checkbox checkbox-success checkbox-circle">
                                            <input type="checkbox" class="styled" id="answer_add_good" checked={good} disabled>
                                            <label for="answer_add_good"></label>
                                        </span>
                                    </td>
                                    <td class="text-right">
                                        <a href="" onclick={answer_delete}><i data-toggle="tooltip" data-placement="top" title="Supprimer" class="fa fa-red fa-trash fa-lg"/></a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="text-right">
                        <button type="reset" class="btn btn-danger" onclick={answers_clear}>Effacer</button>
                        <button type="submit" class="btn btn-success" onclick={questions_add} id="question_button_add">Ajouter la question</button>
                    </div>
                </div>
            </div>
        </form>
    </div> 
    
     <script>
        var self = this;
        self.answers = [];
        self.theme = [];
        self.alert = { display:false, message:""};
        
        loader.show();
        loader.hide();

        this.on('mount',function() 
        {
            opts.themes.get(opts.page.id);
            refreshTooltip();
            
            $("#question").markdown({
                fullscreen:{enable:false},
                iconlibrary:'fa',
                resize:'vertical',
                hiddenButtons:'Image',
            })
        });
        
        opts.themes.on('themes_get', function(json) 
        {
            self.theme = json.data;
            self.update();
            
            $('#theme_title').show();
        });
        
        opts.questions.on('question_add', function(json)
        {
            var alert = $('#alert_block');
            self.alert.message = "";
            self.alert.display = true;
            
            if(json.error == false)
            {
                var question = $('#question');
                var wording = $('#answer_add_wording');
                var good = $('#answer_add_good');
                
                wording.val("");
                good.attr("checked", false);
                question.val("");
                
                self.answers = [];
                
                alert.removeClass('alert-danger');
                alert.addClass('alert-success');
                
                opts.questions.refresh();
            }
            else
            {
                alert.addClass('alert-danger');
                alert.removeClass('alert-success');
            }
            
            self.enableForm(true);
            self.alert.message = json.message;
            self.update();
        });
        
        //----------------
        //UTILS ----------
        //----------------
        
        self.checkAnswerInput = function(){
            var input = $('#answer_add_wording');
            
            if(!input.val())
            {
                input.parent().addClass('has-error');
                return false;
            }
            else
            {
               input.parent().removeClass('has-error');
               return true;
            }
        };
        
        self.enableForm = function(enable)
        {
            //button
            var button = $('#question_button_add');
            var question = $('#question');
             
            if(enable == true)
            {
                button.removeAttr('disabled');
                question.removeAttr('disabled');
            }
            else
            {
                button.attr('disabled', 'disabled');
                question.attr('disabled', 'disabled');
            }
        }
        
        
        //----------------
        //SIGNAL ---------
        //----------------
        
        questions_add(e) {
            var questionParams = { wording : "", answers : self.answers, theme_id : self.theme.id };
            questionParams.wording = this.question.value;
            self.enableForm(false);
            
            opts.questions.add(questionParams);
        };

        answers_clear(e) {
            $('#questions_form')[0].reset();
            self.answers = [];
            self.update();
        };
        
           
        answer_add(e){
            if(self.checkAnswerInput())
            {
                var wording = $('#answer_add_wording');
                var good = $('#answer_add_good');
                
                var newAnswer = new Answer();
                newAnswer.id = self.answers.length;
                newAnswer.wording = wording.val();
                newAnswer.good = good.is(":checked");
                self.answers.push(newAnswer);

                wording.val("");
                good.attr("checked", false);
                refreshTooltip();
            }
        }
        
        answer_input(e){
            self.checkAnswerInput();
        }
        
        answer_delete(e){
            var index = self.answers.map(byId).indexOf(e.item.id);
            self.answers.splice(index, 1);
            
            self.update();
            refreshTooltip();
        }
        
        
    </script>
</questions_add>