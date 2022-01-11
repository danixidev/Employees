<?php

use App\Http\Controllers\FileController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UsersController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::put('login', [UsersController::class, 'login']);
Route::put('passwordrecover', [UsersController::class, 'passwordRecover']);
Route::put('checktoken', [UsersController::class, 'checkToken']);

Route::middleware('ValidatePermission')->prefix('employee')->group(function(){
    Route::put('/add', [UsersController::class, 'add']);
    Route::get('/getall', [UsersController::class, 'getAll']);
    Route::get('/get/{id}', [UsersController::class, 'get']);
    Route::get('/profile', [UsersController::class, 'profile']);
    Route::put('/modify/{id}', [UsersController::class, 'modify']);
    Route::put('delete/{id}', [UsersController::class, 'delete']);
    Route::post('uploadimage', [FileController::class, 'uploadImage']);
    Route::put('/logout', [UsersController::class, 'logout']);
});

    