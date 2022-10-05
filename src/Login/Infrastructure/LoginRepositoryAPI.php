<?php

namespace App\Login\Infrastructure;

use App\Login\Domain\LoginRepository;
use Symfony\Component\HttpClient\Exception\TransportException;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface;
use Symfony\Contracts\HttpClient\HttpClientInterface;
use Symfony\Contracts\HttpClient\ResponseInterface;

class LoginRepositoryAPI implements LoginRepository
{
    private $client;

    public function __construct(HttpClientInterface $client)
    {
        $this->client = $client;
    }

    /**
     * @throws TransportExceptionInterface
     */
    public function sendCredentials(string $email, string $password): ResponseInterface
    {
        $response = $this->client->request('POST', 'https://reqres.in/api/login', [
            'json' => ['email' => $email, 'password' => $password],
        ]);
        if ($response->getStatusCode() !== 200){
            throw new TransportException('No se ha podido realizar el acceso',402);
        }
        return $response;
    }
}