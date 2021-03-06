<?php

namespace App\Http\Controllers;

use Validator;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Lang;
use Carbon\Carbon;

use Auth;
use App\Http\Controllers\Controller;
use App\Models\Account;
use App\Models\Evaluation;

class AccountController extends Controller
{
    public function __construct()
    {
    }

    public function vueLogin()
    {
        return view('account.login');
    }
     
     //----------------------------
     //API ------------------------
     //----------------------------
    
    /**
    * @api {get} /accounts Request Accounts information
    * @apiName      getAll
    * @apiGroup Accounts
    *
    * @apiSuccess {Boolean} error an error occur
    * @apiSuccess {String} message description of action
    * @apiSuccess {Array} data all accounts
    * @apiSampleRequest off
    */
    public function getAll()
    {
        try
        {
            $accounts = Account::all();
            return response()->json(["error"=> false, "message" =>"", "data" => $accounts]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    /**
    * @api {get} /accounts/{id} Request Account information
    * @apiName      getById
    * @apiGroup Accounts
    *
    * @apiParam {Number} id Accounts unique ID
    *
    * @apiSuccess {Boolean} error an error occur
    * @apiSuccess {String} message description of action
    * @apiSuccess {Array} data current account information
    * @apiSampleRequest off
    */
    public function getById($id)
    {
        try
        {
            $account = Account::find($id);
        
            //if we can't get account
            if($account === NULL)
                return response()->json(["error" => true, "message" => Lang::get('account.notFoundById', ["id" => $id]), "data" => []]);
            
            //return wanted account
            return response()->json(["error" => false, "message" => "", "data" => $account]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    /**
    * @api {get} /accounts/profile Request Account information
    * @apiName      getCurrentAccount
    * @apiGroup Accounts
    *
    * @apiSuccess {Boolean} error an error occur
    * @apiSuccess {String} message description of action
    * @apiSuccess {Array} data Current account information
    * @apiSampleRequest off
    */
    public function getProfil()
    {
        try
        {
            $account = Auth::user();
            return response()->json(["error" => false, "message" => "", "data" => $account]); //return current account
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }

    /**
    * @api {post} /accounts/login Try to login
    * @apiName      login
    * @apiGroup Accounts
    *
    * @apiParam {String} username Account username
    * @apiParam {String} password Account password
    *
    * @apiSuccess {Boolean} error an error occur
    * @apiSuccess {String} message description of action
    * @apiSuccess {Array} data empty
    * @apiSampleRequest off
    */
    public function postLogin(Request $request)
    {
        try
        {
            $username = $request->input('username');
            $password = $request->input('password');

            if(Auth::attempt(['username' => $username, 'password' => $password]))
                return response()->json(["error" => false, "message" => Lang::get('account.loginOk'), "data" => []]);
  
            return response()->json(["error" => true, "message" => Lang::get('account.loginFail'), "data" => []]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }

    /**
    * @api {get} /accounts/logout Logout
    * @apiName      logout
    * @apiGroup Accounts
    *
    *
    * @apiSuccess {Boolean} error an error occur
    * @apiSuccess {String} message description of action
    * @apiSuccess {Array} data empty
    * @apiSampleRequest off
    */
    public function getLogout()
    {
        try
        {
           Auth::logout();
           return response()->json(["error" => false, "message" => Lang::get('account.logoutOk'), "data" => []]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
    
    
    /**
    * @api {get} /accounts/select2/candidates Candidates list
    * @apiName  select2 Candidates
    * @apiGroup Accounts
    *
    * @apiSuccess {Boolean} error an error occur
    * @apiSuccess {String} message description of action
    * @apiSuccess {Array} data all accounts
    * @apiSampleRequest off
    */
    public function getSelect2Candidates(Request $request)
    {
        try
        {
           $q = $request->q;
           $accounts = Account::where('rank', 0)->where('lastname', 'LIKE', '%'.$q.'%')
                            ->orWhere('rank', 0)->where('firstname', 'LIKE', '%'.$q.'%')
                            ->orderBy('lastname')->get();
            
           return response()->json(["error" => false, "message" => '', "data" => $accounts]);
        }
        catch(\Exception $e)
        {
            return response()->json(["error" => true, "message" => $e->getMessage(), "data" => []]); //fail something is wrong
        }
    }
}
