<?php

namespace App\Home\Infrastructure;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\Attribute\AttributeBag;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\HttpFoundation\Session\Storage\NativeSessionStorage;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    #[Route('/home', name: 'app_home')]
    public function index(): Response
    {
        $session = new Session(new NativeSessionStorage(), new AttributeBag());
        $token = $session->get('token');

        return $this->render('home/index.html.twig', [
            'controller_name' => 'HomeController',
            'token' => $token,
        ]);
    }
}
