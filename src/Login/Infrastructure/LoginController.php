<?php

namespace App\Login\Infrastructure;

use App\Login\Application\LoginType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\Attribute\AttributeBag;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\HttpFoundation\Session\Storage\NativeSessionStorage;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Contracts\HttpClient\Exception\TransportExceptionInterface;

class LoginController extends AbstractController
{
    #[Route('/login', name: 'app_login')]
    public function login(Request $request, LoginRepositoryAPI $loginRepositoryAPI): Response
    {
        $session = new Session(new NativeSessionStorage(), new AttributeBag());


        $form = $this->createForm(LoginType::class);
        $form->handleRequest($request);
        if ($form->isSubmitted()) {

            try {
                $response = $loginRepositoryAPI->sendCredentials($form->getData()->getEmail(), $form->getData()->getPassword());
            } catch (TransportExceptionInterface $e) {
                dump($e->getMessage());die;
            }

            $token = current(json_decode($response->getContent(),true));

            $session->set('token', $token);



            return $this->redirectToRoute('app_home');
        }

        return $this->renderForm('login/index.html.twig', [
            'controller_name' => 'LoginController',
            'form'=> $form
        ]);
    }

    #[Route('/logout', name: 'app_logout')]
    public function logout(): Response
    {
        $session = new Session();
        $session->clear();
        return $this->redirectToRoute('app_login');
    }
}
