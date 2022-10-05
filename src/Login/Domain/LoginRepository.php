<?php

namespace App\Login\Domain;

use Symfony\Contracts\HttpClient\ResponseInterface;

interface LoginRepository
{
    public function sendCredentials(string $email, string $password): ResponseInterface;
}