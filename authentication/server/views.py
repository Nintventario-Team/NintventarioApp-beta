import json
import os
from django.http import FileResponse
from rest_framework.decorators import api_view
from rest_framework.response import Response
from . serializers import ProductSerializer, UserSerializer
from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token
from django.shortcuts import get_object_or_404
from rest_framework import status
from rest_framework.decorators import authentication_classes, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication


UPLOAD_DIR = 'uploads'  # Directorio donde se guardarán los archivos JSON

@api_view(['POST'])
def login(request):

    user=get_object_or_404(User, username=request.data['username'])
    if not user.check_password(request.data['password']):

        return Response({"error": "Invalid password"}, status=status.HTTP_400_BAD_REQUEST)
    
    token, created =Token.objects.get_or_create(user=user)
    serializer=UserSerializer(instance=user)
    return Response({"Token": token.key, "user": serializer.data}, status=status.HTTP_200_OK)



@api_view(['POST'])
def register(request):

    serializer =  UserSerializer(data=request.data)

    if serializer.is_valid():
        serializer.save()

        user=User.objects.get(username=serializer.data['username'])
        user.set_password(serializer.data['password'])
        user.save()

        token = Token.objects.create(user=user)
        return Response({'token': token.key, 'user': serializer.data}, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)


@api_view(['POST'])
@authentication_classes([TokenAuthentication])
@permission_classes([IsAuthenticated])
def profile(request):
    print(request.user.password)
    return Response("You are logged with {}".format(request.user.username), status=status.HTTP_200_OK)



@api_view(['POST'])
def upload_json(request):
    try:
        if 'file' not in request.FILES:
            return Response({"error": "No file provided"}, status=status.HTTP_400_BAD_REQUEST)

        json_file = request.FILES['file']
        json_data = json.load(json_file)

        if not os.path.exists(UPLOAD_DIR):
            os.makedirs(UPLOAD_DIR)

        file_path = os.path.join(UPLOAD_DIR, 'data.json')
        with open(file_path, 'w') as f:
            json.dump(json_data, f)

        return Response({"message": "JSON file processed and saved successfully!"}, status=status.HTTP_200_OK)
    except Exception as e:
        return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
def get_json(request):
    file_path = os.path.join(UPLOAD_DIR, 'data.json')
    if os.path.exists(file_path):
        return FileResponse(open(file_path, 'rb'), content_type='application/json')
    else:
        return Response({"error": "File not found"}, status=status.HTTP_404_NOT_FOUND)